local UTF8 = {}

function UTF8.utf8toarray(input)
    if input == nil then return {} end
    local t = {}
    local line = {}
    local len = string.len(input)
    local left = len
    local arr = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    local skip
    local str
    while left ~= 0 do
        skip = false
        local tmp = string.byte(input, -left)
        if tmp == 124 then
            local tmp1 = string.byte(input, -left + 1)
            if tmp1 == 99 then
                left = left - 10
                skip = true
            elseif tmp1 == 110 then
                left = left - 2
                skip = true
                if #line > 0 then table.insert(t, line) end
                line = {}
            elseif tmp1 == 114 then
                left = left - 2
                skip = true
            end
        end
        if not skip then
            local i = #arr
            while arr[i] do
                if tmp >= arr[i] then
                    left = left - i
                    break
                end
                i = i - 1
            end

            str = string.sub(input, -left - i, -left - 1)
            table.insert(line, str)
        end
    end
    if #line > 0 then table.insert(t, line) end
    return t
end

return UTF8