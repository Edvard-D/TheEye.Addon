local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED
this.name = "UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED"

local GetTime = GetTime
local InputGroupElapsedTimerStart = TheEyeAddon.Timers.InputGroupElapsedTimerStart
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Helpers.Core.InputGroupRegisterListeningTo
local math = math
local select = select
local table = table
local UnitCastingInfo = UnitCastingInfo


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spell ID# #SPELL#ID#
    }
}
]]


this.gameEvents =
{
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
    InputGroupElapsedTimerStart(inputGroup, remainingTime, "UNIT_SPELLCAST_START_ELAPSED_TIMER_END", inputGroup.inputValues)
end

local function CalculateCurrentValue(inputValues, startTime)
    local _
    local elapsedTime = math.huge
    local expectedSpellID = inputValues[2]
    local spellID
    local unit = inputValues[1]

    if startTime == nil then
        startTime, _, _, _, _, spellID = select(4, UnitCastingInfo(unit))
    end

    if spellID == expectedSpellID then
        elapsedTime = GetTime() - (startTime / 1000)
    end

    return elapsedTime
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, ...)
    local spellID
    local unit

    if event == "UNIT_SPELLCAST_START_ELAPSED_TIMER_END" then
        _, unit, spellID = ...
    elseif event == "UNIT_SPELLCAST_INSTANT" then
        _, unit, _, spellID = ...
    else
        unit, _, spellID = ...
    end
    
    return table.concat({ unit, spellID })
end

function this:Evaluate(inputGroup, event, ...)
    local elapsedTime

    if event == "UNIT_SPELLCAST_INSTANT" then
        local castTimestamp = ...
        elapsedTime = CalculateCurrentValue(inputGroup.inputValues, castTimestamp)
    else -- UNIT_SPELLCAST_START, UNIT_SPELLCAST_CHANNEL_START, UNIT_SPELLCAST_START_ELAPSED_TIMER_END
        elapsedTime = CalculateCurrentValue(inputGroup.inputValues)
    end

    TimerStart(inputGroup.inputValues, elapsedTime)

    if inputGroup.currentValue ~= elapsedTime then
        inputGroup.currentValue = elapsedTime
        return true, this.name, elapsedTime
    end
end