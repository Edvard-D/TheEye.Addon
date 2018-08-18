TheEyeAddon.Events.Evaluators.UNIT_HEALTH_PERCENT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_HEALTH_PERCENT_CHANGED

local math = math
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_HEALTH"
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    local healthMax = UnitHealthMax(unit)

    if healthMax == 0 then
        healthMax = math.huge
    end
    
    return UnitHealth(unit) / healthMax
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event)
    local healthPercent = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= healthPercent then
        inputGroup.currentValue = healthPercent
        return true, this.key, healthPercent
    end
end