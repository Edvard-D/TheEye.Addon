local TheEyeAddon = TheEyeAddon
TheEyeAddon.Comparisons = {}
this = TheEyeAddon.Comparisons


function this.EqualTo(value1, value2)
    return value1 == value2
end

function this.GreaterThan(value1, value2)
    return value1 > value2
end

function this.LessThan(value1, value2)
    return value1 < value2
end

function this.GreatThanEqualTo(value1, value2)
    return value1 >= value2
end

function this.LessThanEqualTo(value1, value2)
    return value1 < value2
end