local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.SPELL_CHARGE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.SPELL_CHARGE_CHANGED
this.name = "SPELL_CHARGE_CHANGED"

local GetSpellCharges = GetSpellCharges
local GetTime = GetTime
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Evaluators.InputGroupRegisterListeningTo
local select = select
local StartEventTimer = TheEyeAddon.Timers.StartEventTimer
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
    for i=1, #combatLogEvents do
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

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
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
    if event ~= "UNIT_SPELLCAST_TIMER_END" then
        local cooldownStart, cooldownDuration = select(3, GetSpellCharges(inputGroup.inputValues[1]))
        local remainingTime = (cooldownStart + cooldownDuration) - GetTime()
        StartEventTimer(remainingTime, "UNIT_SPELLCAST_TIMER_END", inputGroup.inputValues[1])
    end

    local charges = CalculateCurrentValue(inputGroup.inputValues)
    if inputGroup.currentValue ~= charges then
        inputGroup.currentValue = charges
        return true, this.name, charges
    end
end