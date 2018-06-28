local TheEyeAddon = TheEyeAddon

local UnitCanAttack = UnitCanAttack
local select = select


-- inputValues = { --[[attackerUnit]] "_", --[[attackedUnit]] "_" }
--      All values must be declared, "_" will throw an error.
TheEyeAddon.Events.Evaluators.Unit_CanAttack_Unit =
{
    type = "STATE",
    reevaluateEvents =
    {
        PLAYER_TARGET_CHANGED = true
    },
    gameEvents =
    {
        "PLAYER_TARGET_CHANGED"
    }
}

function TheEyeAddon.Events.Evaluators.Unit_CanAttack_Unit:CalculateCurrentState(inputValues)
    return UnitCanAttack(inputValues[1], inputValues[2])
end

function TheEyeAddon.Events.Evaluators.Unit_CanAttack_Unit:Evaluate(valueGroup)
    return UnitCanAttack(valueGroup.inputValues[1], valueGroup.inputValues[2])
end