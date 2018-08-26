TheEyeAddon.Events.Evaluators.PLAYER_SPELL_CHARGE_COOLDOWN_DURATION_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.PLAYER_SPELL_CHARGE_COOLDOWN_DURATION_CHANGED

local initialTimerLength = 0.01
local InputGroupDurationTimerStart = TheEyeAddon.Helpers.Timers.InputGroupDurationTimerStart
local InputGroupRegisterListeningTo = TheEyeAddon.Managers.Evaluators.InputGroupRegisterListeningTo
local select = select
local SpellChargeCooldownRemainingTimeGet = TheEyeAddon.Helpers.Player.SpellChargeCooldownRemainingTimeGet
local StartEventTimer = TheEyeAddon.Helpers.Timers.StartEventTimer
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


function this:SetupListeningTo(inputGroup)
    InputGroupRegisterListeningTo(inputGroup,
    {
        listeningToKey = "COMBAT_LOG",
        evaluator = this,
        inputValues = { "SPELL_CAST_SUCCESS", "player", "_" }
    })
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
        local inputGroup = ...

        if inputGroup.eventData["sourceUnit"] == "player" then
            spellID = inputGroup.eventData["spellID"]
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
            return true, this.key
        end
    end
end