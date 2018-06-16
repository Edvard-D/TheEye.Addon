local TheEyeAddon = TheEyeAddon
TheEyeAddon.Operators = {}


function TheEyeAddon.Operators.EqualTo(value1, value2)
    if value1 == value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Operators.NotEqualTo(value1, value2)
    if value1 ~= value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Operators.GreaterThan(value1, value2)
    if value1 > value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Operators.LessThan(value1, value2)
    if value1 < value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Operators.GreaterThanEqualTo(value1, value2)
    if value1 >= value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Operators.LessThanEqualTo(value1, value2)
    if value1 <= value2 then
        return true
    else
        return false
    end
end