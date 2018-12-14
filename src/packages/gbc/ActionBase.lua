--[[
 
Copyright (c) 2015 gameboxcloud.com
 
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
 
]]

local ActionBase = cc.class("ActionBase")

function ActionBase:ctor(instance)
    self._instance = instance
    self:init()
end

function ActionBase:getInstance()
    return self._instance
end

function ActionBase:getInstanceConfig()
    return self._instance.config
end

function ActionBase:init()
end

function ActionBase:hasAuthority(authorization)
    local config = self._instance.config.server
    return config.authorization == authorization
end

function ActionBase:runAction(actionName, args, redis, params)
    local ret, err = self._instance:runAction(actionName, args, redis, true, params)
    if err then
        cc.printerr(err)
    end
    return ret, err
end

return ActionBase
