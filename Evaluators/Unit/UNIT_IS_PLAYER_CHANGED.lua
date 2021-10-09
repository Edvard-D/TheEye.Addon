TheEye.Core.Evaluators.UNIT_IS_PLAYER_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_IS_PLAYER_CHANGED

local UnitIsPlayer = UnitIsPlayer


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
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    
    return UnitIsPlayer(unit)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local isPlayer = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= isPlayer then
        inputGroup.currentValue = isPlayer
        return true, this.key
    end
end