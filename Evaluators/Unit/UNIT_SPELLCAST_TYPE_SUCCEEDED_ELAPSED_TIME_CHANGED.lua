-- @DEBUG Doesn't account for spells cast by units other than "player" prior to them being
--       watched by this evaluator.
TheEye.Core.Evaluators.UNIT_SPELLCAST_TYPE_SUCCEEDED_ELAPSED_TIME_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_SPELLCAST_TYPE_SUCCEEDED_ELAPSED_TIME_CHANGED

local GetTime = GetTime
local InputGroupElapsedTimerStart = TheEye.Core.Helpers.Timers.InputGroupElapsedTimerStart
local InputGroupRegisterListeningTo = TheEye.Core.Managers.Evaluators.InputGroupRegisterListeningTo
local math = math
local select = select
local table = table


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spell Type# #SPELL#TYPE#
    }
}
]]


this.reevaluateEvents =
{
    UNIT_SPELLCAST_CHANNEL_START = true,
    UNIT_SPELLCAST_CHANNEL_STOP = true,
    UNIT_SPELLCAST_START = true,
    UNIT_SPELLCAST_STOP = true,
    UNIT_SPELLCAST_SUCCEEDED = true,
}
this.gameEvents =
{
    "UNIT_SPELLCAST_CHANNEL_START",
    "UNIT_SPELLCAST_CHANNEL_STOP",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP",
    "UNIT_SPELLCAST_SUCCEEDED",
}
this.customEvents =
{
    "UNIT_SPELLCAST_TYPE_SUCCEEDED_ELAPSED_TIMER_END"
}
this.succeededTimestamps = {}
this.unitLastCastTypes = {}


local function TimerStart(inputGroup, elapsedTime)
    InputGroupElapsedTimerStart(inputGroup, elapsedTime, "UNIT_SPELLCAST_TYPE_SUCCEEDED_ELAPSED_TIMER_END", inputGroup.inputValues)
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

function this:GetKey(event, _, inputValues) -- UNIT_SPELLCAST_TYPE_SUCCEEDED_ELAPSED_TIMER_END
    unit = inputValues[1]
    spellType = inputValues[2]
    
    return table.concat({ unit, spellType })
end

function this:Evaluate(inputGroup, event, ...)
    local elapsedTime
    local unit = select(1, ...)

    if event == "UNIT_SPELLCAST_CHANNEL_START" then
        this.unitLastCastTypes[unit] = "CHANNEL"

        if unit == inputGroup.inputValues[1] and inputGroup.inputValues[2] == "CHANNEL" then
            this.succeededTimestamps[inputGroup.key] = nil
        end
    elseif event == "UNIT_SPELLCAST_START" then
        this.unitLastCastTypes[unit] = "CAST"

        if unit == inputGroup.inputValues[1] and inputGroup.inputValues[2] == "CAST" then
            this.succeededTimestamps[inputGroup.key] = nil
        end
    elseif event == "UNIT_SPELLCAST_CHANNEL_STOP" or event == "UNIT_SPELLCAST_STOP" then
        this.unitLastCastTypes[unit] = nil
    elseif event == "UNIT_SPELLCAST_SUCCEEDED"
        and unit == inputGroup.inputValues[1]
        and (this.unitLastCastTypes[unit] == inputGroup.inputValues[2] or this.unitLastCastTypes[unit] == nil)
        then
        this.succeededTimestamps[inputGroup.key] = GetTime()
    end

    elapsedTime = CalculateCurrentValue(inputGroup)

    if inputGroup.currentValue ~= elapsedTime then
        TimerStart(inputGroup, elapsedTime)
        inputGroup.currentValue = elapsedTime
        return true, this.key
    end
end