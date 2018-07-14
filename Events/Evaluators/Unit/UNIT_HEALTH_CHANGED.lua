local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_HEALTH_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_HEALTH_CHANGED
this.name = "UNIT_HEALTH_CHANGED"

local UnitHealth = UnitHealth


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.gameEvents =
{
    "UNIT_HEALTH"
}

function this:CalculateCurrentValue(inputValues)
    return UnitHealth(inputValues[1])
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event, unit)
    local health = UnitHealth(unit)

    if inputGroup.currentValue ~= health then
        inputGroup.currentValue = health
        return true, this.name, health
    end
end