local TheEyeAddon = TheEyeAddon

local UnitCanAttack = UnitCanAttack


TheEyeAddon.Events.Evaluators.Target_Attackable =
{
    gameEvents = { "PLAYER_TARGET_CHANGED" },
    Evaluate = function()
        return "default", UnitCanAttack("player", "target")
    end,
    SetInitialState = function(self, valueGroup)
        valueGroup.currentState = select(2, self.Evaluate())
    end
}