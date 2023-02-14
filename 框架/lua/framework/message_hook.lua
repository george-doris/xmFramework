local message = require "jass.message"

--hook消息
local MessageHook = {}

local _message = {} --时间组

function MessageHook.Add(msg_type,code,key,fn)
    local m = _message[msg_type]
    if m==nil then
        m = {}
        _message[msg_type] = m
    end
    m[code] = fn
end

function MessageHook.Remove(msg_type,code,key)
    local m = _message[msg_type]
    if m==nil then
        return
    end
    m[code] = nil
end

function message.hook(msg)
    local m = _message[msg.type]
    if m then
        local fn = m[msg.code]
        if fn then
            if not fn(msg) then
                return false
            end
        end
    end
    -- 返回true表示，war3会继续处理这个消息
    return true
end


return MessageHook