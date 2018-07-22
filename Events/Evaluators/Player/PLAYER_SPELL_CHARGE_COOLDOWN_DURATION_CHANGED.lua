local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.PLAYER_SPELL_CHARGE_COOLDOWN_DURATION_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.PLAYER_SPELL_CHARGE_COOLDOWN_DURATION_CHANGED
this.name = "PLAYER_SPELL_CHARGE_COOLDOWN_DURATION_CHANGED"

local initialTimerLength = 0.01
local InputGroupDurationTimerStart = TheEyeAddon.Timers.InputGroupDurationTimerStart
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Helpers.Core.InputGroupRegisterListeningTo
local select = select
local SpellChargeCooldownRemainingTimeGet = TheEyeAddon.Events.Helpers.Player.SpellChargeCooldownRemainingTimeGet
local StartEventTimer = TheEyeAddon.Timers.StartEventTimer
local tostring = tostring


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
    for i = 1, #combatLogEvents do
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
        InputGroupDurationTimerStart(inputGroup, remainingTime, "SPELL_CHARGE_COOLDOWN_TIMER_END", inputGroup.inputValues)
    end
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = SpellChargeCooldownRemainingTimeGet(inputGroup.inputValues)
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
        local remainingTime = SpellChargeCooldownRemainingTimeGet(inputGroup.inputValues)
    
        if inputGroup.currentValue ~= remainingTime then
            TimerStart(inputGroup, remainingTime)
            inputGroup.currentValue = remainingTime
            return true, this.name, remainingTime
        end
    end
end