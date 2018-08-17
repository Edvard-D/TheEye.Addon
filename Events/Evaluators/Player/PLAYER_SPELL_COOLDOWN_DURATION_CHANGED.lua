-- @TODO add coverage for cooldowns being reset
TheEyeAddon.Events.Evaluators.PLAYER_SPELL_COOLDOWN_DURATION_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.PLAYER_SPELL_COOLDOWN_DURATION_CHANGED
this.name = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED"

local GetSpellCooldown = GetSpellCooldown
local GetTime = GetTime
local initialTimerLength = 0.01
local InputGroupDurationTimerStart = TheEyeAddon.Helpers.Timers.InputGroupDurationTimerStart
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Helpers.Core.InputGroupRegisterListeningTo
local select = select
local StartEventTimer = TheEyeAddon.Helpers.Timers.StartEventTimer
local tostring = tostring


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#SpellID# #INT# }
}
]]


this.reevaluateEvents =
{
    SPELL_UPDATE_USABLE = true,
}
this.gameEvents =
{
    "UNIT_SPELLCAST_SUCCEEDED",
    "SPELL_UPDATE_USABLE",
}
this.customEvents =
{
    "SPELL_COOLDOWN_TIMER_END",
}


local function TimerStart(inputGroup, remainingTime)
    if remainingTime == initialTimerLength then
        StartEventTimer(remainingTime, "SPELL_COOLDOWN_TIMER_END", inputGroup.inputValues)
    else
        InputGroupDurationTimerStart(inputGroup, remainingTime, "SPELL_COOLDOWN_TIMER_END", inputGroup.inputValues)
    end
end

local function RemainingTimeCalculate(startTime, duration)
    local remainingTime = (startTime + duration) - GetTime()

    if remainingTime < 0 then
        remainingTime = 0
    end

    return remainingTime
end

local function CalculateCurrentValue(inputValues)
    local startTime, duration = GetSpellCooldown(inputValues[1])
    return RemainingTimeCalculate(startTime, duration)
end

function this:InputGroupSetup(inputGroup)
    local gcdStartTime, gcdDuration = GetSpellCooldown(61304)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue == RemainingTimeCalculate(gcdStartTime, gcdDuration) then
        inputGroup.currentValue = 0
        inputGroup.isGCD = true
    else
        inputGroup.isGCD = false
        TimerStart(inputGroup, inputGroup.currentValue)
    end
end

function this:GetKey(event, ...)
    local spellID

    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        local unit = ...
        if unit == "player" then
            spellID = select(3, ...)
        end
    else -- SPELL_COOLDOWN_TIMER_END
        local inputValues = select(2, ...)
        spellID = inputValues[1]
    end

    return tostring(spellID)
end

function this:Evaluate(inputGroup, event)
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        TimerStart(inputGroup, initialTimerLength)
        inputGroup.isGCD = false
    else
        local gcdDuration = select(2, GetSpellCooldown(61304))
        local remainingTime = CalculateCurrentValue(inputGroup.inputValues)

        if inputGroup.currentValue ~= remainingTime
            and (gcdDuration == 0 or inputGroup.isGCD == false)
            then
            if remainingTime == 0 then
                inputGroup.isGCD = true
            end
            TimerStart(inputGroup, remainingTime)
            inputGroup.currentValue = remainingTime
            return true, this.name, remainingTime
        end
    end
end