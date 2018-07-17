local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.SPELL_COOLDOWN_DURATION_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.SPELL_COOLDOWN_DURATION_CHANGED
this.name = "SPELL_COOLDOWN_DURATION_CHANGED"

local GetSpellCooldown = GetSpellCooldown
local GetTime = GetTime
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Evaluators.InputGroupRegisterListeningTo
local StartEventTimer = TheEyeAddon.Timers.StartEventTimer
local select = select
local tostring = tostring
local updateRate = 0.1


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#SpellID# #INT# }
}
]]

this.customEvents =
{
    "SPELL_COOLDOWN_UPDATE"
}
local combatLogEvents =
{
    "SPELL_CAST_SUCCESS",
}

local function TryStartTimer(inputGroup, remainingTime)
    if remainingTime ~= 0 then
        local timerLength
        if remainingTime < updateRate then
            timerLength = remainingTime
        else
            timerLength = updateRate
        end

        StartEventTimer(timerLength, "SPELL_COOLDOWN_UPDATE", inputGroup.inputValues[1])
    end
end

local function CalculateCurrentValue(inputValues)
    local start, duration = GetSpellCooldown(inputValues[1])
    local remainingTime = (start + duration) - GetTime()

    if remainingTime < 0 then
        remainingTime = 0
    end
    return remainingTime
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
    TryStartTimer(inputGroup, inputGroup.currentValue)
end

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

function this:GetKey(event, ...)
    local spellID = nil

    if event == "SPELL_CAST_SUCCESS" then
        local combatLogData = ...

        if combatLogData["sourceUnit"] == "player" then
            spellID = combatLogData["spellID"]
        end
    else
        spellID = select(2, ...)
    end

    return tostring(spellID)
end

function this:Evaluate(inputGroup, event)
    local remainingTime = CalculateCurrentValue(inputGroup.inputValues)

    if event == "SPELL_CAST_SUCCESS" then
        remainingTime = updateRate
    end

    TryStartTimer(inputGroup, remainingTime)

    print("remainingTime: " .. tostring(remainingTime))
    if inputGroup.currentValue ~= remainingTime then
        inputGroup.currentValue = remainingTime
        return true, this.name, remainingTime
    end
end