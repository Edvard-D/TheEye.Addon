-- @TODO Implement tracking of friendly units using beneficial and harmful AoE spells.
TheEyeAddon.Events.Evaluators.UNIT_COUNT_CLOSE_TO_UNIT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_COUNT_CLOSE_TO_UNIT_CHANGED

local bit = bit
local GetTime = GetTime
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Helpers.Core.InputGroupRegisterListeningTo
local math = math
local playerInitiatedMultiplier = 3
local reevaluateRate = 0.5
local reevaluateMaxTimestampElapsedTime = 2.5
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
    PLAYER_TARGET_CHANGED = true,
    SPELL_DAMAGE = true,
    SWING_DAMAGE = true,
    UNIT_CAN_ATTACK_UNIT_CHANGED = true,
    UNIT_DESTROYED = true,
    UNIT_DIED = true,
    UNIT_DISSIPATES = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
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
        listeningToKey = "UNIT_CAN_ATTACK_UNIT_CHANGED",
        evaluator = this,
        inputValues = { "player", inputGroup.inputValues[1] }
    })
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = 0
    inputGroup.events =
    {
        pending =
        {
            SPELL_DAMAGE = {},
            SWING_DAMAGE = {},
        },
    }
end

local function CurrentEventTryAddData(inputGroup, eventData)
    if inputGroup.events.current == nil then
        inputGroup.events.current = { destGUIDs = {} }
    end
    local currentEvent = inputGroup.events.current

    print("destUnit hostility (should return 0 for not hostile, >0 for hostile): " .. tostring(bit.band(eventData.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE)))
    if (eventData.event == "SWING_DAMAGE"
            and bit.band(eventData.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == 0 -- @TODO Check that this works
            and eventData.destGUID == UnitGUID(inputGroup.inputValues[1])) -- @TODO Create table that stores the GUIDs for each unitID
        or (eventData.event == "SPELL_DAMAGE"
            and bit.band(eventData.destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) > 0)
        then
        if currentEvent.event == nil then
            currentEvent.event = eventData.event
            currentEvent.timestamp = eventData.timestamp
            currentEvent.sourceGUID = eventData.sourceGUID
        end
        table.insert(currentEvent.destGUIDs, eventData.destGUID)
    end
end

local function CurrentEventEvaluateForPending(inputGroup, eventData)
    local currentEvent = inputGroup.events.current

    if currentEvent.event == "SWING_DAMAGE" then
        table.insert(inputGroup.events.pending.SWING_DAMAGE, currentEvent)
    elseif #currentEvent.destGUIDs > 1
        and table.hasvalue(currentEvent.destGUIDs, UnitGUID(inputGroup.inputValues[1]) == true) -- @TODO Create table that stores the GUIDs for each unitID
        then
        table.insert(inputGroup.events.pending.SPELL_DAMAGE, currentEvent)
    else
        inputGroup.events.current = nil
        CurrentEventTryAddData(inputGroup, eventData)
    end
end

local function GUIDsGetFromPendingEvents()
    local guids = {}

    if inputGroup.inputValues[2] == COMBATLOG_OBJECT_REACTION_HOSTILE then
        local pendingEvents = inputGroup.events.pending.SPELL_DAMAGE

        for i = 1, #pendingEvents do
            local event = pendingEvents[i]

            local wasPlayerInitiated
            if event.sourceGUID == UnitGUID("player") then -- @TODO Create table that stores the GUIDs for each unitID
                wasPlayerInitiated = true
            end

            for i2 = 1, #event.destGUIDs do
                table.insert(guids, { wasPlayerInitiated = wasPlayerInitiated, guid = event.destGUIDs[i2] })
            end
        end
    else
        local pendingEvents = inputGroup.events.pending.SWING_DAMAGE
        for i = 1, #pendingEvents do
            table.insert(guids, { guid = pendingEvents[i].sourceGUID })
        end
    end

    return guids
end

local function GUIDInfoGetFromPendingEvents()
    local guids = GUIDsGetFromPendingEvents()
    local guidWeights = {}
    local highestGUIDWeight = 0

    for i = 1, #guids do
        local guidData = guids[i]
        local guid = guidData.guid
        if inputGroup.invalidGUIDs[guid] ~= true then
            local weightedValue = 1
            if guidData.wasPlayerInitiated == true then
                weightedValue = weightedValue * playerInitiatedMultiplier
            end

            if guidWeights[guid] == nil then
                guidWeights[guid] = weightedValue
            else
                guidWeights[guid] = guidWeights[guid] + weightedValue
            end

            if guidWeights[guid] > highestGUIDWeight then
                highestGUIDWeight = guidWeights[guid]
            end
        end
    end

    return guids, guidWeights, highestGUIDWeight
end

local function UnitCountGetFromPendingEvents(inputGroup)
    local unitCount = 0
    local guids, guidWeights, highestGUIDWeight = GUIDInfoGetFromPendingEvents()
    
    if #guids > 0 then
        for i = 1, #guids do
            unitCount = unitCount + (guidWeights[guids[i]] / highestGUIDWeight)
        end

        inputGroup.events.pending.SPELL_DAMAGE = {}
        inputGroup.events.pending.SWING_DAMAGE = {}
    end

    return UnitCountsReevaluate(unitCount)
end

local function UnitCountsReevaluate(unitCount)
    local currentTime = GetTime()

    if inputGroup.evaluatedUnitCounts == nil then
        inputGroup.evaluatedUnitCounts = {}
    end
    table.insert(inputGroup.evaluatedUnitCounts,
    {
        timestamp = currentTime,
        unitCount = unitCount + 0.5,
    })

    for i = #inputGroup.evaluatedUnitCounts, 1, -1 do
        if currentTime - inputGroup.evaluatedUnitCounts[i].timestamp > reevaluateMaxTimestampElapsedTime then
            inputGroup.evaluatedUnitCounts[i] = nil
        else
            unitCount = unitCount + inputGroup.evaluatedUnitCounts[i]
        end
    end

    return math.floor(unitCount / #inputGroup.evaluatedUnitCounts)
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
    local unitCount = inputGroup.currentValue

    if event == "UNIT_CAN_ATTACK_UNIT_CHANGED" or event == "PLAYER_TARGET_CHANGED" then
        table.cleararray(inputGroup.unevaluatedEvents)
        unitCount = 0
    else -- combatLogEvents
        local eventInputGroup = ...
        local eventData = eventInputGroup.eventData

        if event == "SPELL_DAMAGE" or event == "SWING_DAMAGE" then
            local currentEvent = inputGroup.events.current
            if currentEvent == nil or currentEvent.timestamp == eventData.timestamp then
                CurrentEventTryAddData(inputGroup, eventData)
            else
                local lastEvaluationTimestamp
                if inputGroup.evaluatedUnitCounts ~= nil and #inputGroup.evaluatedUnitCounts > 0 then
                    lastEvaluationTimestamp = inputGroup.evaluatedUnitCounts[#inputGroup.evaluatedUnitCounts].timestamp
                end

                if lastEvaluationTimestamp == nil
                    or GetTime() - lastEvaluationTimestamp > reevaluateRate
                    then
                    CurrentEventEvaluateForPending(inputGroup, eventData)
                else
                    unitCount = UnitCountGetFromPendingEvents(inputGroup)
                end

                inputGroup.events.current = nil
                CurrentEventTryAddData(inputGroup, eventData)
            end
        elseif currentEvent ~= nil then -- UNIT_DESTROYED, UNIT_DIED, UNIT_DISSIPATES
            if inputGroup.invalidGUIDs == nil then
                inputGroup.invalidGUIDs = {}
            end
            inputGroup.invalidGUIDs[event.destGUID] = true
        end
    end

    if inputGroup.currentValue ~= unitCount then
        inputGroup.currentValue = unitCount
        return true, this.name, unitCount
    end
end