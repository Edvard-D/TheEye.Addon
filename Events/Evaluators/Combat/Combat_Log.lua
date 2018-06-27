local TheEyeAddon = TheEyeAddon

local table = table


-- inputValues = { --[[eventName]] "" }
TheEyeAddon.Events.Evaluators.Combat_Log =
{
    type = "EVENT",
    gameEvents =
    {
        "COMBAT_LOG_EVENT_UNFILTERED"
    }
}

function TheEyeAddon.Events.Evaluators.Combat_Log:GetKey()
    self.currentEventInfo = { CombatLogGetCurrentEventInfo() }
    return self.currentEventInfo[2]
end

function TheEyeAddon.Events.Evaluators.Combat_Log:Evaluate(savedValues)
    TheEyeAddon.Events.Coordinator:SendCustomEvent(self.currentEventInfo[2], self.currentEventInfo)
end