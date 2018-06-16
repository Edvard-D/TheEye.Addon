local TheEyeAddon = TheEyeAddon
TheEyeAddon.Comparisons = {}


function TheEyeAddon.Comparisons.EqualTo(value1, value2)
    if value1 == value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Comparisons.NotEqualTo(value1, value2)
    if value1 ~= value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Comparisons.GreaterThan(value1, value2)
    if value1 > value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Comparisons.LessThan(value1, value2)
    if value1 < value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Comparisons.GreaterThanEqualTo(value1, value2)
    if value1 >= value2 then
        return true
    else
        return false
    end
end

function TheEyeAddon.Comparisons.LessThanEqualTo(value1, value2)
    if value1 <= value2 then
        return true
    else
        return false
    end
end