TheEye.Core.Evaluators.UNIT_SPEED_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_SPEED_CHANGED

local GetUnitSpeed = GetUnitSpeed


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    UPDATE = true,
}
this.customEvents =
{
    "UPDATE",
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    
    return GetUnitSpeed(unit)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local speed = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= speed then
        inputGroup.currentValue = speed
        return true, this.key
    end
end