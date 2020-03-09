TheEye.Core.Evaluators.UNIT_IN_VEHICLE_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_IN_VEHICLE_CHANGED

local UnitInVehicle = UnitInVehicle


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_ENTERED_VEHICLE",
    "UNIT_EXITED_VEHICLE",
}

local function CalculateCurrentValue(inputValues)
    return UnitInVehicle(inputValues[1])
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, unit)
    return unit
end

function this:Evaluate(inputGroup, event)
    local inVehicle = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= inVehicle then
        inputGroup.currentValue = inVehicle
        return true, this.key
    end
end