-- @DEBUG Doesn't account for situations where a targeted unit changes from friendly to hostile,
--  but isn't in combat.
TheEyeAddon.Evaluators.UNIT_CAN_ATTACK_UNIT_CHANGED = {}
local this = TheEyeAddon.Evaluators.UNIT_CAN_ATTACK_UNIT_CHANGED

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
    local canAttack = UnitCanAttack(inputValues[1], inputValues[2])
    
    return canAttack or false
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup)
    local canAttack = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= canAttack then
        inputGroup.currentValue = canAttack
        return true, this.key
    end
end