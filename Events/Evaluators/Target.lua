local TheEyeAddon = TheEyeAddon

local UnitCanAttack = UnitCanAttack


TheEyeAddon.Events.Evaluators.Target_Attackable =
{
    registerTo = { "PLAYER_TARGET_CHANGED" },
    Evaluate = function()
        return UnitCanAttack("player", "target")
    end
}