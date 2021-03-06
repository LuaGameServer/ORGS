
local gbc = cc.import("#gbc")
local AchvAction = cc.class("AchvAction", gbc.ActionBase)

AchvAction.ACCEPTED_REQUEST_TYPE = "websocket"

--登陆初始化
function AchvAction:login(args)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local role = player:getRole()
    local role_data = role:get()
    local achvs = player:getAchvs()
    
    local lastTime = args.lastTime
    local loginTime = args.loginTime
    
    if not achvs:Login(instance:getConnectId(), "achv.onLogin", lastTime, loginTime, role_data.id) then
        self:onLogin(args)
    end
    return true
end

function AchvAction:onLogin(_args)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local role = player:getRole()
    local role_data = role:get()
    local achvs = player:getAchvs()
    achvs:LoadAll(instance:getConnectId(), "achv.onLoad", role_data.id)
end

function AchvAction:onLoad(args)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local achvs = player:getAchvs()
    achvs:updates(args)
    instance:sendPack("AchvList", {
        items = args
    })
end

function AchvAction:event(args)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local achvs = player:getAchvs()
    achvs:process(instance:getConnectId(), "achv.onUpdate", args.action_type, args.action_id, args.action_place, args.action_count, args.action_override)
end

function AchvAction:onUpdate(_args, _redis, param)
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local achvs = player:getAchvs()
    local id = param.id
    local achv = achvs:get(id)
    instance:sendPack("AchvList", {
        items = {achv:get()},
    })
end

function AchvAction:finishAction(args)
    local id = args.id
    local instance = self:getInstance()
    local player = instance:getPlayer()
    local achvs = player:getAchvs()
    local props = player:getProps()
    local role = player:getRole()
    
    local ok, err, cfg = achvs:Finish(instance:getConnectId(), nil, id)
    if not ok then
        return ok, err
    end
    
    if cfg then
        --增加奖励
        local ok, err, items, rewards = props:AddRewards(instance:getConnectId(), "prop.OnProps", cfg.rewards, role)
        
        if not ok then
            return ok, err
        end
        if items then
            instance:sendPack("Props", {
                items = items,
            })
        end
        if rewards then
            instance:sendPack("Rewards", {
                items = rewards,
            })
        end
        instance:sendPack("Role", role:get())
    end
    instance:sendDelete("AchvItem", id, 0)
    return true
end

return AchvAction
