TheEye.Core.Evaluators.UNIT_CLASSIFICATION_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_CLASSIFICATION_CHANGED

local UnitClassification = UnitClassification


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true,
    UNIT_CLASSIFICATION_CHANGED = true,
    UNIT_THREAT_SITUATION_UPDATE = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_CLASSIFICATION_CHANGED",
    "UNIT_THREAT_SITUATION_UPDATE",
}

local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]

    return UnitClassification(unit)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local classification = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= classification then
        inputGroup.currentValue = classification
        return true, this.key
    end
end