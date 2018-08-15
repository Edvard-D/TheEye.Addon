TheEyeAddon.Events.Evaluators.PLAYER_SPELL_CHARGE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.PLAYER_SPELL_CHARGE_CHANGED
this.name = "PLAYER_SPELL_CHARGE_CHANGED"

local GetSpellCharges = GetSpellCharges
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Helpers.Core.InputGroupRegisterListeningTo
local select = select
local SpellChargeCooldownRemainingTimeGet = TheEyeAddon.Events.Helpers.Player.SpellChargeCooldownRemainingTimeGet
local StartEventTimer = TheEyeAddon.Helpers.Timers.StartEventTimer
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

local function TimerStart(inputValues)
    local remainingTime = SpellChargeCooldownRemainingTimeGet(inputValues)
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
        local combatLogData = ...
        spellID = combatLogData["spellID"]
    end

    return table.concat({ spellID })
end

function this:Evaluate(inputGroup, event)
    local charges = CalculateCurrentValue(inputGroup.inputValues)
    if event ~= "UNIT_SPELLCAST_TIMER_END" and inputGroup.currentValue == charges then
        charges = charges - 1
    end
    TimerStart(inputGroup.inputValues)

    if inputGroup.currentValue ~= charges then
        inputGroup.currentValue = charges
        return true, this.name, charges
    end
end