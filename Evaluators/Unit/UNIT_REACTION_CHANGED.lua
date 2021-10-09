TheEye.Core.Evaluators.UNIT_REACTION_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_REACTION_CHANGED

local UnitReaction = UnitReaction


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Unit 1# #UNIT# }
    inputValues = { #LABEL#Unit 2# #UNIT# }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true,
    UNIT_THREAT_SITUATION_UPDATE = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_THREAT_SITUATION_UPDATE",
}

local function CalculateCurrentValue(inputValues)
    local unit1 = inputValues[1]
    local unit2 = inputValues[2]
    
    return UnitReaction(unit1, unit2)
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local reaction = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= reaction then
        inputGroup.currentValue = reaction
        return true, this.key
    end
end