local TheEyeAddon = TheEyeAddon

local UnitCanAttack = UnitCanAttack
local select = select


-- inputValues = nil
TheEyeAddon.Events.Evaluators.Target_Attackable =
{
    type = "STATE",
    gameEvents =
    {
        "PLAYER_TARGET_CHANGED"
    }
}

function TheEyeAddon.Events.Evaluators.Target_Attackable:CalculateCurrentState()
    return self.Evaluate()
end

function TheEyeAddon.Events.Evaluators.Target_Attackable:GetKey()
    return "default"
end

function TheEyeAddon.Events.Evaluators.Target_Attackable:Evaluate()
    return UnitCanAttack("player", "target")
end