local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
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
    self.rawEventInfo = { CombatLogGetCurrentEventInfo() }
    return self.rawEventInfo[2]
end

function TheEyeAddon.Events.Evaluators.Combat_Log:Evaluate()
    self.formattedEventInfo = {}

    for i,valueName in ipairs(TheEyeAddon.Events.Evaluators.Combat_Log.EventValueNames[self.rawEventInfo[2]]) do
        self.formattedEventInfo[valueName] = self.rawEventInfo[i]
    end

    TheEyeAddon.Events.Coordinator:SendCustomEvent(self.formattedEventInfo["event"], self.formattedEventInfo)
end