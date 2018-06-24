local TheEyeAddon = TheEyeAddon

local UnitCanAttack = UnitCanAttack
local select = select


-- inputValues = nil
TheEyeAddon.Events.Evaluators.Target_Attackable =
{
    gameEvents =
    {
        "PLAYER_TARGET_CHANGED"
    }
}

function TheEyeAddon.Events.Evaluators.Target_Attackable:SetInitialState(valueGroup)
    valueGroup.currentState = select(2, self.Evaluate())
end

function TheEyeAddon.Events.Evaluators.Target_Attackable:Evaluate()
    return "default", UnitCanAttack("player", "target")
end