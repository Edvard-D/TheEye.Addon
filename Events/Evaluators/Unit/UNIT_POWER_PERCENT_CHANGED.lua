local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_POWER_PERCENT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_POWER_PERCENT_CHANGED
this.name = "UNIT_POWER_PERCENT_CHANGED"

local table = table
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Power Type# #POWER#
    }
}
]]


this.gameEvents =
{
    "UNIT_POWER_UPDATE"
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    local powertype = inputValues[2]
    return UnitPower(unit, powertype) / UnitPowerMax(unit, powertype)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, unit, powerType)
    return table.concat({ unit, powerType })
end

function this:Evaluate(inputGroup, event, unit)
    local powerPercent = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= powerPercent then
        inputGroup.currentValue = powerPercent
        return true, this.name, powerPercent
    end
end