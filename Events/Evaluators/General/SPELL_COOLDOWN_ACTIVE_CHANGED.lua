local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.SPELL_COOLDOWN_ACTIVE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.SPELL_COOLDOWN_ACTIVE_CHANGED
this.name = "SPELL_COOLDOWN_ACTIVE_CHANGED"

local GetSpellCooldown = GetSpellCooldown
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Evaluators.InputGroupRegisterListeningTo
local StartEventTimer = TheEyeAddon.Timers.StartEventTimer
local select = select
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

function this:CalculateCurrentValue(inputValues)
    local cooldownDuration = select(2, GetSpellCooldown(inputValues[1]))
    local isCooldownActive = cooldownDuration ~= 0
    return isCooldownActive
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
    local cooldownDuration = select(2, GetSpellCooldown(inputGroup.inputValues[1]))
    if event ~= "UNIT_SPELLCAST_TIMER_END" then
        StartEventTimer(cooldownDuration, "UNIT_SPELLCAST_TIMER_END", inputGroup.inputValues[1])
    end

    local isCooldownActive = cooldownDuration ~= 0
    if inputGroup.currentValue ~= isCooldownActive then
        inputGroup.currentValue = isCooldownActive
        return true, this.name, isCooldownActive
    end
end