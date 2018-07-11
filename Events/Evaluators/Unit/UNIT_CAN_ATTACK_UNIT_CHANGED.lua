local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_CAN_ATTACK_UNIT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_CAN_ATTACK_UNIT_CHANGED
this.name = "UNIT_CAN_ATTACK_UNIT_CHANGED"

local UnitCanAttack = UnitCanAttack


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Attacker Unit# #UNIT#
        #LABEL#Attacked Unit# #UNIT#
    }
}
]]


reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED"
}


function this:CalculateCurrentState(inputValues)
    return UnitCanAttack(inputValues[1], inputValues[2])
end

function this:Evaluate(valueGroup)
    local canAttack = UnitCanAttack(valueGroup.inputValues[1], valueGroup.inputValues[2])

    if valueGroup.currentState ~= canAttack then
        valueGroup.currentState = canAttack
        return true, this.name, canAttack
    end
end