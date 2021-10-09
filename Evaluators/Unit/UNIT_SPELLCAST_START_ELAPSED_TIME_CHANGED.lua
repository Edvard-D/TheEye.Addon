TheEye.Core.Evaluators.UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED

local GetTime = GetTime
local InputGroupElapsedTimerStart = TheEye.Core.Helpers.Timers.InputGroupElapsedTimerStart
local InputGroupRegisterListeningTo = TheEye.Core.Managers.Evaluators.InputGroupRegisterListeningTo
local math = math
local select = select
local table = table
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spell ID# #SPELL#ID#
    }
}
]]

this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_SPELLCAST_CHANNEL_START",
    "UNIT_SPELLCAST_CHANNEL_STOP",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP"
}
this.customEvents =
{
    "UNIT_SPELLCAST_START_ELAPSED_TIMER_END"
}


function this:SetupListeningTo(inputGroup)
    InputGroupRegisterListeningTo(inputGroup,
    {
        listeningToKey = "UNIT_SPELLCAST_INSTANT",
        evaluator = this,
        inputValues = inputGroup.inputValues
    })
end

local function TimerStart(inputGroup, elapsedTime)
    InputGroupElapsedTimerStart(inputGroup, elapsedTime, "UNIT_SPELLCAST_START_ELAPSED_TIMER_END", inputGroup.inputValues)
end

local function CalculateCurrentValue(inputValues, spellID, startTime)
    local elapsedTime = math.huge
    local expectedSpellID = inputValues[2]
    local unit = inputValues[1]
    local retrievedSpellID
    local retrievedStartTime
    
    retrievedStartTime, _, _, _, _, retrievedSpellID = select(4, UnitCastingInfo(unit))
    if retrievedSpellID == nil then
        retrievedStartTime, _, _, _, retrievedSpellID = select(4, UnitChannelInfo(unit))
    end

    if retrievedStartTime ~= nil then
        retrievedStartTime = retrievedStartTime / 1000
    end
    startTime = startTime or retrievedStartTime
    spellID = spellID or retrievedSpellID

    if spellID == expectedSpellID then
        elapsedTime = GetTime() - startTime
    end

    return elapsedTime
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= math.huge then
        TimerStart(inputGroup, inputGroup.currentValue)
    end
end

function this:GetKey(event, ...)
    local spellID
    local unit

    if event == "UNIT_SPELLCAST_START_ELAPSED_TIMER_END" then
        local inputValues = select(2, ...)
        unit = inputValues[1]
        spellID = inputValues[2]
    elseif event == "UNIT_SPELLCAST_INSTANT" then
        local eventInputGroup = ...
        unit = eventInputGroup.inputValues[1]
        spellID = eventInputGroup.inputValues[2]
    else
        unit, _, spellID = ...
    end
    
    return table.concat({ unit, spellID })
end

function this:Evaluate(inputGroup, event, ...)
    local elapsedTime

    if event == "UNIT_SPELLCAST_INSTANT" then
        local eventInputGroup = ...
        elapsedTime = CalculateCurrentValue(inputGroup.inputValues, eventInputGroup.inputValues[2],
                eventInputGroup.castTimestamp)
    else -- PLAYER_TARGET_CHANGED, UNIT_SPELLCAST_START, UNIT_SPELLCAST_CHANNEL_START, UNIT_SPELLCAST_START_ELAPSED_TIMER_END
        elapsedTime = CalculateCurrentValue(inputGroup.inputValues)
    end

    if inputGroup.currentValue ~= elapsedTime then
        TimerStart(inputGroup, elapsedTime)
        inputGroup.currentValue = elapsedTime
        return true, this.key
    end
end