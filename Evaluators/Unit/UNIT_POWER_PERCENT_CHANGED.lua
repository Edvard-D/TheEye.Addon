TheEye.Core.Evaluators.UNIT_POWER_PERCENT_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_POWER_PERCENT_CHANGED

local powerIDs = TheEye.Core.Data.powerIDs
local table = table
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Power ID# #POWER#ID#
    }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_POWER_UPDATE"
}


local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    local powerID = inputValues[2]

    return UnitPower(unit, powerID) / UnitPowerMax(unit, powerID)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, unit, powerName)
    return table.concat({ unit, powerIDs[powerName] })
end

function this:Evaluate(inputGroup, event, unit)
    local powerPercent = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= powerPercent then
        inputGroup.currentValue = powerPercent
        return true, this.key
    end
end