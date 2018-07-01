local TheEyeAddon = TheEyeAddon
local thisName = "Unit_CanAttack_Unit"
local this = TheEyeAddon.Events.Evaluators[thisName]

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


this.type = "STATE"
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
    return UnitCanAttack(valueGroup.inputValues[1], valueGroup.inputValues[2])
end