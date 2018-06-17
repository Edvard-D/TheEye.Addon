local TheEyeAddon = TheEyeAddon

local UnitCanAttack = UnitCanAttack


TheEyeAddon.EventHandlers.Target_Attackable =
{
    registerTo = { PLAYER_REGEN_DISABLED, PLAYER_TARGET_CHANGED },
    Evaluate = function()
        UnitCanAttack("player", "target")
    end,
    HandleEvent = function()
        self:Evaluate()
    end
}