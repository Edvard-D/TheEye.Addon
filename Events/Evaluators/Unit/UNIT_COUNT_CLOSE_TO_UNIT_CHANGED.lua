-- @TODO Implement tracking of friendly units using beneficial and harmful AoE spells.
TheEyeAddon.Events.Evaluators.UNIT_COUNT_CLOSE_TO_UNIT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_COUNT_CLOSE_TO_UNIT_CHANGED

local bit = bit
local GetTime = GetTime
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Helpers.Core.InputGroupRegisterListeningTo
local math = math
local playerInitiatedMultiplier = 3
local reevaluateRate = 0.25
local reevaluateMaxTimestampElapsedTime = 5
local table = table
local UnitCanAttack = UnitCanAttack
local UnitGUID = UnitGUID
local unpack = unpack


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Reaction Mask# #MASK#REACTION#
    }
}
]]


this.reevaluateEvents =
{
    SPELL_DAMAGE = true,
    SWING_DAMAGE = true,
    UNIT_AFFECTING_COMBAT_CHANGED = true,
    UNIT_DESTROYED = true,
    UNIT_DIED = true,
    UNIT_DISSIPATES = true,
}
local combatLogEvents =
{
    "SPELL_DAMAGE",
    "SWING_DAMAGE",
    "UNIT_DESTROYED",
    "UNIT_DIED",
    "UNIT_DISSIPATES",
}


function this:SetupListeningTo(inputGroup)
    for i = 1, #combatLogEvents do
        InputGroupRegisterListeningTo(inputGroup,
        {
            listeningToKey = "COMBAT_LOG",
            evaluator = this,
            inputValues = { combatLogEvents[i], "_", "_" }
        })
    end

    InputGroupRegisterListeningTo(inputGroup,
    {
        listeningToKey = "UNIT_AFFECTING_COMBAT_CHANGED",
        evaluator = this,
        inputValues = { "player", }
    })
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = 0
    inputGroup.lastUpdateTimestamp = 0
    inputGroup.groupedUnits =
    {
        guids = {},
    }
    inputGroup.events =
    {
        pending =
        {
            SPELL_DAMAGE = {},
            SWING_DAMAGE = {},
        },
    }
end


-- Current/Pending Events
local function EventIsValid(inputGroup, eventData)
    if (eventData.event == "SWING_DAMAGE"
        and bit.band(eventData.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == 0
        and eventData.destGUID == UnitGUID(inputGroup.inputValues[1])) -- @TODO Create table that stores the GUIDs for each unitID
    or (eventData.event == "SPELL_DAMAGE"
        and bit.band(eventData.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0)
    then
        return true
    end
end

local function CurrentEventTryAddData(inputGroup, eventData)
    if inputGroup.events.current == nil then
        inputGroup.events.current = { destGUIDs = {}, }
    end
    local currentEvent = inputGroup.events.current

    if EventIsValid(inputGroup, eventData) then
        if currentEvent.event == nil then
            currentEvent.sourceGUID = eventData.sourceGUID
            currentEvent.event = eventData.event
            currentEvent.timestamp = eventData.timestamp
        end
        table.insert(currentEvent.destGUIDs, eventData.destGUID)
    end
end

local function CurrentEventEvaluateForPending(inputGroup)
    local currentEvent = inputGroup.events.current

    if currentEvent.event == "SWING_DAMAGE" then
        table.insert(inputGroup.events.pending.SWING_DAMAGE, currentEvent)
    elseif #currentEvent.destGUIDs > 1 -- SPELL_DAMAGE
        and table.hasvalue(currentEvent.destGUIDs, UnitGUID(inputGroup.inputValues[1])) == true -- @TODO Create table that stores the GUIDs for each unitID
        then
        currentEvent.wasInitiatorPlayer = currentEvent.sourceGUID == UnitGUID("player") -- @TODO Create table that stores the GUIDs for each unitID
        table.insert(inputGroup.events.pending.SPELL_DAMAGE, currentEvent)
    end
end

local function PendingEventsGet(inputGroup)
    if inputGroup.inputValues[2] == COMBATLOG_OBJECT_REACTION_HOSTILE then
        return inputGroup.events.pending.SPELL_DAMAGE
    else
        return inputGroup.events.pending.SWING_DAMAGE
    end
end

local function PendingEventsReset(inputGroup)
    inputGroup.events.pending.SPELL_DAMAGE = {}
    inputGroup.events.pending.SWING_DAMAGE = {}
    inputGroup.events.current = nil
end


-- GroupedUnits
local function GroupedUnitAddEventData(groupedUnits, guid, eventData)    
    if groupedUnits[guid] == nil then
        groupedUnits[guid] =
        {
            guid = guid,
            events = {},
        }
        table.insert(groupedUnits.guids, guid)
    end

    table.insert(groupedUnits[guid].events,
        {
            timestamp = eventData.timestamp,
            wasInitiatorPlayer = eventData.wasInitiatorPlayer,
        }
    )
end

local function GroupedUnitRemove(groupedUnits, guid)
    if groupedUnits ~= nil and groupedUnits[guid] ~= nil then
        groupedUnits[guid] = nil
        table.removevalue(groupedUnits.guids, guid)
    end
end

local function GroupedUnitRemoveOldEventData(groupedUnits, guid)
    local currentTime = GetTime()
    local groupedUnit = groupedUnits[guid]
    local oldestTimestamp = groupedUnit.events[1].timestamp

    if currentTime - oldestTimestamp > reevaluateMaxTimestampElapsedTime then
        local events = groupedUnit.events
        for i = #events, 1, -1 do
            if currentTime - events[i].timestamp > reevaluateMaxTimestampElapsedTime then
                table.remove(events, i)
            end
        end

        if #events == 0 then
            GroupedUnitRemove(groupedUnits, guid)
        end
    end
end

local function GroupedUnitsRemoveOldEventData(groupedUnits)
    local guids = groupedUnits.guids
    for i = #guids, 1, -1 do
        GroupedUnitRemoveOldEventData(groupedUnits, guids[i])
    end
end

local function GroupedUnitsUpdateWithPendingEvents(groupedUnits, pendingEvents)
    if #pendingEvents > 0 then
        for i = 1, #pendingEvents do
            local pendingEvent = pendingEvents[i]

            if pendingEvent.event == "SPELL_DAMAGE" then
                local destGUIDs = pendingEvent.destGUIDs
                for j = 1, #destGUIDs do
                    GroupedUnitAddEventData(groupedUnits, destGUIDs[j], pendingEvent)
                end
            else
                GroupedUnitAddEventData(groupedUnits, pendingEvent.sourceGUID, pendingEvent)
            end
        end
    end
end

local function EventWeightGet(event)
    local weightedValue = 1

    if event.wasInitiatorPlayer == true then
        weightedValue = weightedValue * playerInitiatedMultiplier
    end

    return weightedValue
end

local function GroupedUnitWeightGet(groupedUnit)
    local events = groupedUnit.events
    local weight = 0

    for i = 1, #events do
        weight = weight + EventWeightGet(events[i])
    end

    return weight
end

local function GroupedUnitsWeightsUpdate(groupedUnits)
    local guids = groupedUnits.guids
    local highestWeight = 0

    for i = 1, #guids do
        local groupedUnit = groupedUnits[guids[i]]

        groupedUnit.weight = GroupedUnitWeightGet(groupedUnit)
        if groupedUnit.weight > highestWeight then
            highestWeight = groupedUnit.weight
        end
    end

    groupedUnits.highestWeight = highestWeight
end

local function GroupedUnitsUpdate(inputGroup)
    local groupedUnits = inputGroup.groupedUnits

    GroupedUnitsUpdateWithPendingEvents(groupedUnits, PendingEventsGet(inputGroup))
    GroupedUnitsRemoveOldEventData(groupedUnits)
    GroupedUnitsWeightsUpdate(groupedUnits)
end

local function GroupedUnitCountGetWeighted(inputGroup)
    local groupedUnits = inputGroup.groupedUnits
    local unitCount = 0
    
    if groupedUnits ~= nil then
        local guids = groupedUnits.guids
        local highestWeight = groupedUnits.highestWeight

        for i = 1, #guids do
            unitCount = unitCount + (groupedUnits[guids[i]].weight / highestWeight)
        end
    end

    return math.floor(unitCount + 0.5)
end


--[[
@TODO Rework how the inputValue[1] (aka unit) being friendly is handled. Basing it entirely
off of melee swing damage isn't ideal since it's very likely for enemies to be near the unit
without attacking the unit directly. Checking if the unit is performing combat swings on
enemies would likely address part of this, since it's very likely the the unit the player is
basing it off of is "target," and that target is a melee player character.

The melee swing events should be used to create a list of valid enemies to cross reference with
the spell event list. Enemies that have been involved in some type of melee interaction means
they're close to the unit. Other enemies that have been damaged by the same AoE spell as the
enemy involved in the melee interaction are likely "close to" that enemy. As such, it can be
inferred that all those other enemies are also close to the melee unit.
]]
function this:Evaluate(inputGroup, event, ...)
    local eventInputGroup = ...

    if event == "UNIT_AFFECTING_COMBAT_CHANGED" then
        if eventInputGroup.currentValue == false then
            table.cleararray(inputGroup.unevaluatedEvents)
        end
    else -- combatLogEvents
        local eventData = eventInputGroup.eventData

        if event == "SPELL_DAMAGE" or event == "SWING_DAMAGE" then
            local currentEvent = inputGroup.events.current

            if currentEvent ~= nil and currentEvent.timestamp ~= eventData.timestamp then
                CurrentEventEvaluateForPending(inputGroup)

                if eventData.timestamp - inputGroup.lastUpdateTimestamp > reevaluateRate then
                    GroupedUnitsUpdate(inputGroup)
                    inputGroup.lastUpdateTimestamp = eventData.timestamp
                    PendingEventsReset(inputGroup)
                end
            end

            CurrentEventTryAddData(inputGroup, eventData)
        else -- UNIT_DESTROYED, UNIT_DIED, UNIT_DISSIPATES
            GroupedUnitRemove(inputGroup.groupedUnits, eventData.destGUID)
        end
    end

    local unitCount = GroupedUnitCountGetWeighted(inputGroup)
    if inputGroup.currentValue ~= unitCount then
        inputGroup.currentValue = unitCount
        return true, this.name, unitCount
    end
end