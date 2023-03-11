
local JassHelper = {}

---"xxxx"字符串转游戏id
---@param id string
---@return integer
function JassHelper.SToId(id)
    if type(id) ~= "string" then
        print("id no no no")
        Dump(id)
    end
    return (string.byte(id, 1) << 24) + (string.byte(id, 2) << 16) +
               (string.byte(id, 3) << 8) + string.byte(id, 4)
end

return JassHelper