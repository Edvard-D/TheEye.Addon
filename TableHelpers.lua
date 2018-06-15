local table = table

function table.hasvalue(tab, value)
    for k,v in tab do
        if v == value then
            return true
        end
    end

    return false
end