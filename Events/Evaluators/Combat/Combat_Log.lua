local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs
local table = table
local UnitGUID = UnitGUID


-- Evaluators that need combat log data should call custom COMBAT_LOG_REQUESTED
-- event, which will prompt Combat_Log to format and send the current event data.

-- inputValues = { --[[eventName]] "", --[[sourceUnit]] "", --[[destUnit]] "" }
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
        local sourceGUID = self.rawEventInfo[4]
        local destGUID = self.rawEventInfo[8]
        local unitGUIDs = {}

        for k,valueGroup in pairs(self.ValueGroups) do
            local sourceUnit = valueGroup.inputValues[2]
            local destUnit = valueGroup.inputValues[3]

            if sourceUnit ~= "" and unitGUIDs[sourceUnit] == nil then
                unitGUIDs[sourceUnit] = UnitGUID(sourceUnit)
            end
            if destUnit ~= "" and unitGUIDs[destUnit] == nil then
                unitGUIDs[destUnit] = UnitGUID(destUnit)
            end

            if (sourceUnit == "" or sourceGUID == unitGUIDs[sourceUnit]) and
            (destUnit == "" or destGUID == unitGUIDs[destUnit]) then
                return table.concat({ self.rawEventInfo[2], sourceUnit, destUnit })
            end
        end
    end
end

function TheEyeAddon.Events.Evaluators.Combat_Log:Evaluate(valueGroup)
    self.formattedEventInfo = {}

    for i,valueName in ipairs(TheEyeAddon.Events.Evaluators.Combat_Log.EventValueNames[self.rawEventInfo[2]]) do
        self.formattedEventInfo[valueName] = self.rawEventInfo[i]
    end

    self.formattedEventInfo["sourceUnit"] = valueGroup.inputValues[2]
    self.formattedEventInfo["destUnit"] = valueGroup.inputValues[3]

    TheEyeAddon.Events.Coordinator:SendCustomEvent(self.formattedEventInfo["event"], self.formattedEventInfo)
    self.combatLogSent = true
end