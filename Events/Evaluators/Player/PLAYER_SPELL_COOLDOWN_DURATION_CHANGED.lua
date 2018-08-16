-- @TODO add coverage for cooldowns being reset
TheEyeAddon.Events.Evaluators.PLAYER_SPELL_COOLDOWN_DURATION_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.PLAYER_SPELL_COOLDOWN_DURATION_CHANGED
this.name = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED"

local GetSpellCooldown = GetSpellCooldown
local GetTime = GetTime
local InputGroupDurationTimerStart = TheEyeAddon.Helpers.Timers.InputGroupDurationTimerStart
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Helpers.Core.InputGroupRegisterListeningTo
local StartEventTimer = TheEyeAddon.Helpers.Timers.StartEventTimer
local select = select
local tostring = tostring
local initialTimerLength = 0.01


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#SpellID# #INT# }
}
]]


this.gameEvents =
{
    "UNIT_SPELLCAST_SUCCEEDED"
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

local function CalculateCurrentValue(inputValues)
    local startTime, duration = GetSpellCooldown(inputValues[1])
    local remainingTime = (startTime + duration) - GetTime()

    if remainingTime < 0 then
        remainingTime = 0
    end
    return remainingTime
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
    TimerStart(inputGroup, inputGroup.currentValue)
    inputGroup.isGCD = true
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
        local remainingTime = CalculateCurrentValue(inputGroup.inputValues)

        if inputGroup.currentValue ~= remainingTime and inputGroup.isGCD == false then
            if remainingTime == 0 then inputGroup.isGCD = true end
            TimerStart(inputGroup, remainingTime)
            inputGroup.currentValue = remainingTime
            return true, this.name, remainingTime
        end
    end
end