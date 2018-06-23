local TheEyeAddon = TheEyeAddon

local UnitCanAttack = UnitCanAttack


TheEyeAddon.Events.Evaluators.Target_Attackable =
{
    registerTo = { "PLAYER_TARGET_CHANGED" },
    Evaluate = function()
        return "default", UnitCanAttack("player", "target")
    end
}