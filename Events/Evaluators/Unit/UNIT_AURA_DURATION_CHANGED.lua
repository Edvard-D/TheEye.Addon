local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_AURA_DURATION_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_AURA_DURATION_CHANGED
this.name = "UNIT_AURA_DURATION_CHANGED"

local GetTime = GetTime
local InputGroupRegisterListeningTo = TheEyeAddon.Events.Evaluators.InputGroupRegisterListeningTo
local StartEventTimer = TheEyeAddon.Timers.StartEventTimer
local table = table
local UnitAuraGetBySpellID = TheEyeAddon.Auras.UnitAuraGetBySpellID
local unpack = unpack


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #OPTIONAL# #LABEL#Source Unit# #UNIT#
        #LABEL#Destination Unit# #UNIT#
        #LABEL#Spell ID# #SPELL#ID#
    }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED"
}
this.customEvents =
{
    "AURA_DURATION_TIMER_END"
}
local combatLogEvents =
{
    "RANGE_AURA_APPLIED",
    "RANGE_AURA_BROKEN",
    "RANGE_AURA_BROKEN_SPELL",
    "RANGE_AURA_REMOVED",
    "SPELL_AURA_APPLIED",
    "SPELL_AURA_BROKEN",
    "SPELL_AURA_BROKEN_SPELL",
    "SPELL_AURA_REMOVED",
    "SPELL_BUILDING_AURA_APPLIED",
    "SPELL_BUILDING_AURA_BROKEN",
    "SPELL_BUILDING_AURA_BROKEN_SPELL",
    "SPELL_BUILDING_AURA_REMOVED",
    "SPELL_PERIODIC_AURA_APPLIED",
    "SPELL_PERIODIC_AURA_BROKEN",
    "SPELL_PERIODIC_AURA_BROKEN_SPELL",
    "SPELL_PERIODIC_AURA_REMOVED",
}

function this:SetupListeningTo(inputGroup)
    for i=1, #combatLogEvents do
        InputGroupRegisterListeningTo(inputGroup,
        {
            listeningToKey = "COMBAT_LOG",
            evaluator = this,
            inputValues = { combatLogEvents[i], inputGroup.inputValues[1], inputGroup.inputValues[2] }
        })
    end
end

local function NewTimerLengthGet(inputGroup, remainingTime)
    local nextUpdatePoint = 0
    local listeners = inputGroup.listeners
    for i=1, #listeners do
        listener = listeners[i]
        if listener.comparisonValues ~= nil then
            local value = listener.comparisonValues.value
            if value > nextUpdatePoint and value <= remainingTime then
                nextUpdatePoint = value
            end
        end
    end

    return remainingTime - nextUpdatePoint
end

local function TryStartTimer(inputGroup, remainingTime)
    if remainingTime ~= 0 then
        local timerLength = initialTimerLength
        timerLength = NewTimerLengthGet(inputGroup, remainingTime)
        
        StartEventTimer(timerLength, "AURA_DURATION_TIMER_END",
            inputGroup.inputValues[1], inputGroup.inputValues[2], inputGroup.inputValues[3])
    end
end

local function CalculateCurrentValue(inputValues)
    local sourceUnitExpected, destUnit, spellIDExpected = unpack(inputValues)
    local auraData = UnitAuraGetBySpellID(sourceUnitExpected, destUnit, spellIDExpected)
    
    local remainingTime = 0
    if auraData ~= nil then
        remainingTime = auraData[6] - GetTime()
    end

    return remainingTime
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
    TryStartTimer(inputGroup, inputGroup.currentValue)
end

function this:GetKey(event, ...)
    local sourceUnit
    local destUnit
    local spellID

    print("event: " .. event)
    if event == "AURA_DURATION_TIMER_END" then
        sourceUnit, destUnit, spellID = select(2, ...)
    else
        local combatLogData = ...
        sourceUnit = combatLogData["sourceUnit"]
        destUnit = combatLogData["destUnit"]
        spellID = combatLogData["spellID"]
    end

    return table.concat({ sourceUnit, destUnit, spellID })
end

function this:Evaluate(inputGroup, event)
    local remainingTime = CalculateCurrentValue(inputGroup.inputValues)
    TryStartTimer(inputGroup, remainingTime)

    if inputGroup.currentValue ~= remainingTime then
        inputGroup.currentValue = remainingTime
        return true, this.name, remainingTime
    end
end