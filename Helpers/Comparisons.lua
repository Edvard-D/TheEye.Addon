TheEyeAddon.Helpers.Comparisons = {}
this = TheEyeAddon.Helpers.Comparisons

local type = type


local function ValueGet(value)
    if type(value) == "function" then
        value = value()
    end

    return value
end

function this.EqualTo(value, comparisonValues)
    return value == ValueGet(comparisonValues.value)
end

function this.GreaterThan(value, comparisonValues)
    return value > ValueGet(comparisonValues.value)
end

function this.LessThan(value, comparisonValues)
    return value < ValueGet(comparisonValues.value)
end

function this.GreaterThanEqualTo(value, comparisonValues)
    return value >= ValueGet(comparisonValues.value)
end

function this.LessThanEqualTo(value, comparisonValues)
    return value <= ValueGet(comparisonValues.value)
end

function this.Between(value, comparisonValues)
    return value >= ValueGet(comparisonValues.floor) and value <= ValueGet(comparisonValues.ceiling)
end