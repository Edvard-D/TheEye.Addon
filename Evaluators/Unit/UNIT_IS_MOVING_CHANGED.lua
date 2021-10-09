TheEye.Core.Evaluators.UNIT_IS_MOVING_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_IS_MOVING_CHANGED

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
    
    return GetUnitSpeed(unit) > 0
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local isMoving = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= isMoving then
        inputGroup.currentValue = isMoving
        return true, this.key
    end
end