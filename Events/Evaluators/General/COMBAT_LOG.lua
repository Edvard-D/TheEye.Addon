local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.COMBAT_LOG = {}
local this = TheEyeAddon.Events.Evaluators.COMBAT_LOG
this.name = "COMBAT_LOG"

local CombatLogEventDataFormats = TheEyeAddon.Events.CombatLogEventDataFormats
local CombatLogGetCurrentEventInfo = CombatLogGetCurrentEventInfo
local pairs = pairs
local table = table
local UnitGUID = UnitGUID


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Event Name# #EVENT#COMBAT#NAME#
        #OPTIONAL# #LABEL#Source Unit# #UNIT#
        #OPTIONAL# #LABEL#Destination Unit# #UNIT#
    }
}
]]


this.gameEvents =
{
    "COMBAT_LOG_EVENT_UNFILTERED"
}

function this:GetKey(event)
    self.rawEventInfo = { CombatLogGetCurrentEventInfo() }
    
    local sourceGUID = self.rawEventInfo[4]
    local destGUID = self.rawEventInfo[8]
    local unitGUIDs = {}

    for k,inputGroup in pairs(self.InputGroups) do -- @TODO create table that stores the GUIDs for each unitID
        local sourceUnit = inputGroup.inputValues[2]
        local destUnit = inputGroup.inputValues[3]

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

function this:Evaluate(inputGroup, event)
    self.formattedEventInfo = {}

    local eventDataFormat = CombatLogEventDataFormats[self.rawEventInfo[2]]
    local valueNames = eventDataFormat.ValueNames
    for i=1,#valueNames do
        self.formattedEventInfo[valueNames[i]] = self.rawEventInfo[i]
    end

    self.formattedEventInfo["prefix"] = eventDataFormat["prefix"]
    self.formattedEventInfo["suffix"] = eventDataFormat["suffix"]
    self.formattedEventInfo["sourceUnit"] = inputGroup.inputValues[2]
    self.formattedEventInfo["destUnit"] = inputGroup.inputValues[3]

    return true, self.formattedEventInfo["event"], self.formattedEventInfo
end