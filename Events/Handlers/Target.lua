local TheEyeAddon = TheEyeAddon

local UnitCanAttack = UnitCanAttack


TheEyeAddon.Events.Handlers.Target_Attackable =
{
    registerTo = { "PLAYER_REGEN_DISABLED", "PLAYER_TARGET_CHANGED" },
    Evaluate = function()
        return UnitCanAttack("player", "target")
    end
}