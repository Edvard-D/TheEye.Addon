local pairs = pairs
local table = table


-- See: http://lua-users.org/wiki/CopyTable
function table.copy(original)
    local copy
    
    if type(original) == "table" then
        copy = {}
        for originalKey, originalValue in next, original, nil do
            copy[table.copy(originalKey)] = table.copy(originalValue)
        end
    else
        copy = original
    end

    return copy
end

function table.hasvalue(tab, value)
    if tab ~= nil and value ~= nil then
        for i = 1, #tab do
            if tab[i] == value then
                return true
            end
        end
    end

    return false
end

function table.haskey(tab, key)
    if tab ~= nil and key ~= nil then
        if tab[key] ~= nil then
            return true
        end
    end

    return false
end

function table.haskeyvalue(tab, value)
    if tab ~= nil and value ~= nil then
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

function table.insertarrayuniques(toTab, fromTab)
    for i = 1, #fromTab do
        if table.hasvalue(toTab, fromTab[i]) == false then
            table.insert(toTab, fromTab[i])
        end
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
    if tab ~= nil then
        for i = #tab, 1, -1 do
            tab[i] = nil
        end
    end
end

function table.clear(tab)
    for k,v in pairs(tab) do
        tab[k] = nil
    end
end