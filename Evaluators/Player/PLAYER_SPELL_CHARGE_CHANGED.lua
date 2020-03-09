TheEye.Core.Evaluators.PLAYER_SPELL_CHARGE_CHANGED = {}
local this = TheEye.Core.Evaluators.PLAYER_SPELL_CHARGE_CHANGED

local GetSpellCharges = GetSpellCharges
local InputGroupRegisterListeningTo = TheEye.Core.Managers.Evaluators.InputGroupRegisterListeningTo
local select = select
local SpellChargeCooldownRemainingTimeGet = TheEye.Core.Helpers.Player.SpellChargeCooldownRemainingTimeGet
local StartEventTimer = TheEye.Core.Helpers.Timers.StartEventTimer
local table = table


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#SpellID# #INT#, }
}
]]


this.customEvents =
{
    "UNIT_SPELLCAST_TIMER_END",
}
local combatLogEvents =
{
    "SPELL_CAST_SUCCESS",
    "SPELL_BUILDING_CAST_SUCCESS",
    "SPELL_PERIODIC_CAST_SUCCESS",
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

local function CalculateCurrentValue(inputValues)
    local charges = GetSpellCharges(inputValues[1])
    return charges
end

local function TimerStart(inputValues, remainingTime)
    remainingTime = remainingTime or SpellChargeCooldownRemainingTimeGet(inputValues)
    StartEventTimer(remainingTime, "UNIT_SPELLCAST_TIMER_END", inputValues[1])
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
    TimerStart(inputGroup.inputValues)
end

function this:GetKey(event, ...)
    local spellID

    if event == "UNIT_SPELLCAST_TIMER_END" then
        spellID = select(2, ...)
    else
        local inputGroup = ...
        spellID = inputGroup.eventData["spellID"]
    end

    return table.concat({ spellID })
end

function this:Evaluate(inputGroup, event)
    local charges = CalculateCurrentValue(inputGroup.inputValues)
    if event ~= "UNIT_SPELLCAST_TIMER_END" then
        TimerStart(inputGroup.inputValues, 0.01)
    else
        TimerStart(inputGroup.inputValues)
    end

    if inputGroup.currentValue ~= charges then
        inputGroup.currentValue = charges
        return true, this.key
    end
end