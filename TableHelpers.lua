local table = table

function table.hasvalue(tab, value)
    for k,v in tab do
        if v == value then
            return true
        end
    end

    return false
end

function table.removevalue(tab, value)
    local count = 0
    for k,v in tab do
        count = count + 1
        if v == value then
            table.remove(tab, count)
            return
        end
    end
end