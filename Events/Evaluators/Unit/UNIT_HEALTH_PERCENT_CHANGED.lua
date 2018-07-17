local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_HEALTH_PERCENT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_HEALTH_PERCENT_CHANGED
this.name = "UNIT_HEALTH_PERCENT_CHANGED"

local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.gameEvents =
{
    "UNIT_HEALTH"
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    return UnitHealth(unit) / UnitHealthMax(unit)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event, unit)
    local healthPercent = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= healthPercent then
        inputGroup.currentValue = healthPercent
        return true, this.name, healthPercent
    end
end