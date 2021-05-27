TheEye.Core.Evaluators.UNIT_LEVEL_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_LEVEL_CHANGED

local UnitLevel = UnitLevel


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_LEVEL_UP = true,
    PLAYER_TARGET_CHANGED = true,
    UNIT_THREAT_SITUATION_UPDATE = true,
}
this.gameEvents =
{
    "PLAYER_LEVEL_UP",
    "PLAYER_TARGET_CHANGED",
    "UNIT_THREAT_SITUATION_UPDATE",
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    
    return UnitLevel(unit)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local level = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= level then
        inputGroup.currentValue = level
        return true, this.key
    end
end