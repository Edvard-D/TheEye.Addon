local TheEyeAddon = TheEyeAddon

local ipairs = ipairs


-- Evaluators that need combat log data should call custom COMBAT_LOG_REQUESTED
-- event, which will prompt Combat_Log to format and send the current event data.

-- inputValues = { --[[eventName]] "" }
TheEyeAddon.Events.Evaluators.Combat_Log =
{
    type = "EVENT",
    gameEvents =
    {
        "COMBAT_LOG_EVENT_UNFILTERED"
    },
    customEvents =
    {
        "COMBAT_LOG_REQUESTED"
    }
}

function TheEyeAddon.Events.Evaluators.Combat_Log:GetKey(event)
    if event == COMBAT_LOG_EVENT_UNFILTERED then
        self.combatLogSent = false
    elseif self.combatLogSent == false then -- COMBAT_LOG_REQUESTED
        self.rawEventInfo = { CombatLogGetCurrentEventInfo() }
        return self.rawEventInfo[2]
    end
end

function TheEyeAddon.Events.Evaluators.Combat_Log:Evaluate()
    self.formattedEventInfo = {}

    for i,valueName in ipairs(TheEyeAddon.Events.Evaluators.Combat_Log.EventValueNames[self.rawEventInfo[2]]) do
        self.formattedEventInfo[valueName] = self.rawEventInfo[i]
    end

    TheEyeAddon.Events.Coordinator:SendCustomEvent(self.formattedEventInfo["event"], self.formattedEventInfo)
    self.combatLogSent = true
end