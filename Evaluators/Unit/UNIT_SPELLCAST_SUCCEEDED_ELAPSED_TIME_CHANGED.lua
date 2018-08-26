-- @DEBUG Doesn't account for spells cast by units other than "player" prior to them being
--       watched by this evaluator.
TheEyeAddon.Evaluators.UNIT_SPELLCAST_SUCCEEDED_ELAPSED_TIME_CHANGED = {}
local this = TheEyeAddon.Evaluators.UNIT_SPELLCAST_SUCCEEDED_ELAPSED_TIME_CHANGED

local GetTime = GetTime
local InputGroupElapsedTimerStart = TheEyeAddon.Helpers.Timers.InputGroupElapsedTimerStart
local InputGroupRegisterListeningTo = TheEyeAddon.Managers.Evaluators.InputGroupRegisterListeningTo
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
    "UNIT_SPELLCAST_SUCCEEDED",
}
this.customEvents =
{
    "UNIT_SPELLCAST_SUCCEEDED_ELAPSED_TIMER_END"
}
this.succeededTimestamps = {}


function this:SetupListeningTo(inputGroup)
    InputGroupRegisterListeningTo(inputGroup,
    {
        listeningToKey = "UNIT_SPELLCAST_INSTANT",
        evaluator = this,
        inputValues = inputGroup.inputValues
    })
end

local function TimerStart(inputGroup, elapsedTime)
    InputGroupElapsedTimerStart(inputGroup, elapsedTime, "UNIT_SPELLCAST_SUCCEEDED_ELAPSED_TIMER_END", inputGroup.inputValues)
end

local function CalculateCurrentValue(inputGroup)
    local  elapsedTime = math.huge
    
    local suceededTimestamp = this.succeededTimestamps[inputGroup.key]
    if suceededTimestamp ~= nil then
        elapsedTime = GetTime() - suceededTimestamp
    end

    return elapsedTime
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup)
    TimerStart(inputGroup, inputGroup.currentValue)
end

function this:GetKey(event, ...)
    local spellID
    local unit

    if event == "UNIT_SPELLCAST_SUCCEEDED_ELAPSED_TIMER_END" then
        local inputValues = select(2, ...)
        unit = inputValues[1]
        spellID = inputValues[2]
    elseif event == "UNIT_SPELLCAST_INSTANT" then
        local eventInputGroup = ...
        unit = eventInputGroup.inputValues[1]
        spellID = eventInputGroup.inputValues[2]
    else -- UNIT_SPELLCAST_SUCCEEDED
        unit, _, spellID = ...
    end
    
    return table.concat({ unit, spellID })
end

function this:Evaluate(inputGroup, event, ...)
    local elapsedTime

    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        this.succeededTimestamps[inputGroup.key] = GetTime()
    end

    elapsedTime = CalculateCurrentValue(inputGroup)

    if inputGroup.currentValue ~= elapsedTime then
        TimerStart(inputGroup, elapsedTime)
        inputGroup.currentValue = elapsedTime
        return true, this.key
    end
end