local pairs = pairs
local table = table


function table.hasvalue(tab, value)
    for i = 1, #tab do
        if tab[i] == value then
            return true
        end
    end

    return false
end

function table.haskeyvalue(tab, value)
    if tab ~= nil then
        for k,v in pairs(tab) do
            if v == value then
                return true
            end
        end
    end

    return false
end

function table.insertarray(toTab, fromTab)
    for i = 1, #fromTab do
        table.insert(toTab, fromTab[i])
    end
end

function table.removevalue(tab, value)
    if tab ~= nil then
        for i = 1, #tab do
            if tab[i] == value then
                table.remove(tab, i)
                return true
            end
        end
    end
    return false
end

function table.removekeyvalue(tab, value)
    if tab ~= nil then
        local count = 0
        for k,v in pairs(tab) do
            count = count + 1
            if v == value then
                table.remove(tab, count)
                return true
            end
        end
    end
    return false
end

function table.cleararray(tab)
    for i = #tab, 1, -1 do
        tab[i] = nil
    end
end

function table.clear(tab)
    for k,v in pairs(tab) do
        tab[k] = nil
    end
end