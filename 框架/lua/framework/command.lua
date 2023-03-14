local CJ = require "jass.common"
local japi = require "jass.japi"

---@class Command
---命令
local Command = {}

local _command = {}

---添加命令
---@param cmd string|integer 命令
---@param fn function 回调
function Command.Add(cmd, fn) _command[cmd] = fn end

---移除命令
---@param cmd string 命令
function Command.Remove(cmd) _command[cmd] = nil end

local _command_index = 1
---发送命令
---@param cmd string 命令
---@param data any 数据
function Command.Send(cmd, data)
    local msg = { id = _command_index, cmd = cmd, data = data }
    local str = Serialize(msg)
    japi.DzSyncData("xmfm", str)
    _command_index = _command_index + 1
end

---立即发送命令
---@param cmd string 命令
---@param data any 数据
function Command.SendImm(cmd, data)
    local msg = { id = _command_index, cmd = cmd, data = data }
    local str = Serialize(msg)
    japi.DzSyncDataImmediately("xmfm", str)
    _command_index = _command_index + 1
end

local _player_command_index = {
    [0] = 0,
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0,
    [5] = 0,
    [6] = 0,
    [7] = 0,
    [8] = 0,
    [9] = 0,
    [10] = 0,
    [11] = 0,
    [12] = 0,
    [13] = 0,
    [14] = 0,
    [15] = 0,
    [16] = 0,
}

---初始化
local trig = CJ.CreateTrigger()
japi.DzTriggerRegisterSyncData(trig, "xmfm", false)
CJ.TriggerAddAction(trig, function()
    local cmd = japi.DzGetTriggerSyncData()
    local msg = UnSerialize(cmd)
    if msg then
        local player = japi.DzGetTriggerSyncPlayer()
        local player_id = CJ.GetPlayerId(player)
        if msg.id > _player_command_index[player_id] then
            _player_command_index[player_id] = msg.id
            local fn = _command[msg.cmd]
            if fn then fn(player, msg.data) end
        end
    end
end)

return Command
