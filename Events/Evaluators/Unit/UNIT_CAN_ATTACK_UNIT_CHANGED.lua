-- @DEBUG Doesn't account for situations where a targeted unit changes from friendly to hostile,
--  but isn't in combat.
TheEyeAddon.Events.Evaluators.UNIT_CAN_ATTACK_UNIT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_CAN_ATTACK_UNIT_CHANGED

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
    PLAYER_TARGET_CHANGED = true,
    UNIT_THREAT_SITUATION_UPDATE = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_THREAT_SITUATION_UPDATE",
}


local function CalculateCurrentValue(inputValues)
    return UnitCanAttack(inputValues[1], inputValues[2])
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup)
    local canAttack = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= canAttack then
        inputGroup.currentValue = canAttack
        return true, this.key, canAttack
    end
end