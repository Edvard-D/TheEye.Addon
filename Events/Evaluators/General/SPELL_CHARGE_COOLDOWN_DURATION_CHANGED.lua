local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.SPELL_CHARGE_COOLDOWN_DURATION_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.SPELL_CHARGE_COOLDOWN_DURATION_CHANGED
this.name = "SPELL_CHARGE_COOLDOWN_DURATION_CHANGED"

local GetSpellCharges = GetSpellCharges
local GetTime = GetTime
local InputGroupCooldownTimerStart = TheEyeAddon.Timers.InputGroupCooldownTimerStart
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Evaluators.InputGroupRegisterListeningTo
local StartEventTimer = TheEyeAddon.Timers.StartEventTimer
local select = select
local tostring = tostring
local initialTimerLength = 0.01


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#SpellID# #INT# }
}
]]

this.customEvents =
{
    "SPELL_CHARGE_COOLDOWN_TIMER_END"
}
local combatLogEvents =
{
    "SPELL_CAST_SUCCESS",
}

function this:SetupListeningTo(inputGroup)
    for i=1, #combatLogEvents do
        InputGroupRegisterListeningTo(inputGroup,
        {
            listeningToKey = "COMBAT_LOG",
            evaluator = this,
            inputValues = { combatLogEvents[i], "player", "_" }
        })
    end
end

local function TimerStart(inputGroup, remainingTime)
    if remainingTime == initialTimerLength then
        StartEventTimer(remainingTime, "SPELL_CHARGE_COOLDOWN_TIMER_END", inputGroup.inputValues)
    else
        InputGroupCooldownTimerStart(inputGroup, remainingTime, "SPELL_CHARGE_COOLDOWN_TIMER_END", inputGroup.inputValues)
    end
end

local function CalculateCurrentValue(inputValues)
    local start, duration = select(3, GetSpellCharges(inputValues[1]))
    local remainingTime = (start + duration) - GetTime()

    if remainingTime < 0 or remainingTime > 600 then
        remainingTime = 0
    end
    return remainingTime
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
    TimerStart(inputGroup, inputGroup.currentValue)
end

function this:GetKey(event, ...)
    local spellID = nil

    if event == "SPELL_CAST_SUCCESS" then
        local combatLogData = ...

        if combatLogData["sourceUnit"] == "player" then
            spellID = combatLogData["spellID"]
        end
    else
        local inputValues = select(2, ...)
        spellID = inputValues[1]
    end

    return tostring(spellID)
end

function this:Evaluate(inputGroup, event)
    if event == "SPELL_CAST_SUCCESS" then
        TimerStart(inputGroup, initialTimerLength)
    else
        local remainingTime = CalculateCurrentValue(inputGroup.inputValues)
        TimerStart(inputGroup, remainingTime)
    
        if inputGroup.currentValue ~= remainingTime then
            inputGroup.currentValue = remainingTime
            return true, this.name, remainingTime
        end
    end
end