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


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED"
}


function this:CalculateCurrentValue(inputValues)
    return UnitCanAttack(inputValues[1], inputValues[2])
end

function this:Evaluate(inputGroup)
    local canAttack = UnitCanAttack(inputGroup.inputValues[1], inputGroup.inputValues[2])

    if inputGroup.currentValue ~= canAttack then
        inputGroup.currentValue = canAttack
        return true, this.name, canAttack
    end
end