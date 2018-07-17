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

local function CalculateCurrentValue(inputValues)
    return UnitHealth(inputValues[1])
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event, unit)
    local health = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= health then
        inputGroup.currentValue = health
        return true, this.name, health
    end
end