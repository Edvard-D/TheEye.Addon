TheEyeAddon.Comparisons = {}
this = TheEyeAddon.Comparisons


function this.EqualTo(value, comparisonValues)
    return value == comparisonValues.value
end

function this.GreaterThan(value, comparisonValues)
    return value > comparisonValues.value
end

function this.LessThan(value, comparisonValues)
    return value < comparisonValues.value
end

function this.GreaterThanEqualTo(value, comparisonValues)
    return value >= comparisonValues.value
end

function this.LessThanEqualTo(value, comparisonValues)
    return value <= comparisonValues.value
end