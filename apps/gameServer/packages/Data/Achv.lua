
local Base = cc.import(".Base")
local Achv = cc.class("Achv", Base)
local dbConfig = cc.import("#dbConfig")
local Table = cc.import("#Table", ...)

function Achv:ctor()
    Achv.super.ctor(self, Table.Achv)
end

function Achv:getConfig()
    if not self._Config or not self:equalCID(self._Config.id) then
        self._Config = dbConfig.get("cfg_achievement", self:get("cid"))
    end
    return self._Config
end

function Achv:isFinished()
    local cfg = self:getConfig()
    local process = self:get("process")
    if process < cfg.action_count then
        return false
    else
        return true
    end
end

function Achv:process(connectid, action, action_type, action_id, action_place, action_count, action_override)
    local cfg = self:getConfig()
    if cfg then
        if cfg.action_type ~= action_type then
            --类型不一样
            return
        end
        if cfg.action_id ~= 0 and cfg.action_id ~= action_id then
            --id不为0 或者id不相等
            return
        end
        if cfg.action_place ~= 0 and cfg.action_place ~= action_place then
            --位置不匹配
            return
        end
        
        local process = self:get("process")
        if process < cfg.action_count then
            if action_override then
                self:set("process", action_count)
            else
                self:add("process", action_count)
            end
            
            local process = self:get("process")
            local query = self:updateQuery({id = self:getID()}, {process = process})
            self:pushQuery(query, connectid, action, {id = self:getID()})
        end
    end
end

return Achv
