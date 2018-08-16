local pairs = pairs


function table.hasvalue(tab, value)
    for i=1, #tab do
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

function table.removevalue(tab, value)
    if tab ~= nil then
        for i = 1, #tab do
            if tab[i] == value then
                tab[i] = nil
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
                tab[k] = nil
                return true
            end
        end
    end
    return false
end

function table.cleararray(tab)
    for i = 1, #tab do
        tab[i] = nil
    end
end