local TheEyeAddon = TheEyeAddon

local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local ipairs = ipairs
local pairs = pairs
local table = table
local UnitGUID = UnitGUID


-- inputValues = { --[[eventName]] "_", --[[sourceUnit]] "_", --[[destUnit]] "_" }
TheEyeAddon.Events.Evaluators.Combat_Log =
{
    type = "EVENT",
    gameEvents =
    {
        "COMBAT_LOG_EVENT_UNFILTERED"
    }
}

function TheEyeAddon.Events.Evaluators.Combat_Log:GetKey(event)
    self.rawEventInfo = { CombatLogGetCurrentEventInfo() }
    
    local sourceGUID = self.rawEventInfo[4]
    local destGUID = self.rawEventInfo[8]
    local unitGUIDs = {}

    for k,valueGroup in pairs(self.ValueGroups) do
        local sourceUnit = valueGroup.inputValues[2]
        local destUnit = valueGroup.inputValues[3]

        if sourceUnit ~= "_" and unitGUIDs[sourceUnit] == nil then
            unitGUIDs[sourceUnit] = UnitGUID(sourceUnit)
        end
        if destUnit ~= "_" and unitGUIDs[destUnit] == nil then
            unitGUIDs[destUnit] = UnitGUID(destUnit)
        end

        if (sourceUnit == "_" or sourceGUID == unitGUIDs[sourceUnit]) and
        (destUnit == "_" or destGUID == unitGUIDs[destUnit]) then
            return table.concat({ self.rawEventInfo[2], sourceUnit, destUnit })
        end
    end
end

function TheEyeAddon.Events.Evaluators.Combat_Log:Evaluate(valueGroup, event)
    self.formattedEventInfo = {}

    local eventDataFormat = TheEyeAddon.Events.Evaluators.Combat_Log.EventDataFormats[self.rawEventInfo[2]]
    for i,valueName in ipairs(eventDataFormat.ValueNames) do
        self.formattedEventInfo[valueName] = self.rawEventInfo[i]
    end

    self.formattedEventInfo["prefix"] = eventDataFormat["prefix"]
    self.formattedEventInfo["suffix"] = eventDataFormat["suffix"]
    self.formattedEventInfo["sourceUnit"] = valueGroup.inputValues[2]
    self.formattedEventInfo["destUnit"] = valueGroup.inputValues[3]

    return true, self.formattedEventInfo["event"], self.formattedEventInfo
end