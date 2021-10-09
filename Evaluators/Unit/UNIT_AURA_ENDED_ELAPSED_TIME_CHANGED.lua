TheEye.Core.Evaluators.UNIT_AURA_ENDED_ELAPSED_TIME_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_AURA_ENDED_ELAPSED_TIME_CHANGED

local GetTime = GetTime
local InputGroupElapsedTimerStart = TheEye.Core.Helpers.Timers.InputGroupElapsedTimerStart
local InputGroupRegisterListeningTo = TheEye.Core.Managers.Evaluators.InputGroupRegisterListeningTo


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


this.customEvents =
{
    "UNIT_AURA_ENDED_ELAPSED_TIMER_END",
}
local combatLogEvents =
{
    "ENVIRONMENTAL_AURA_BROKEN",
    "ENVIRONMENTAL_AURA_BROKEN_SPELL",
    "ENVIRONMENTAL_AURA_REMOVED",
    "ENVIRONMENTAL_AURA_REMOVED_DOSE",
    "SPELL_AURA_BROKEN",
    "SPELL_AURA_BROKEN_SPELL",
    "SPELL_AURA_REMOVED",
    "SPELL_AURA_REMOVED_DOSE",
    "SPELL_BUILDING_AURA_BROKEN",
    "SPELL_BUILDING_AURA_BROKEN_SPELL",
    "SPELL_BUILDING_AURA_REMOVED",
    "SPELL_BUILDING_AURA_REMOVED_DOSE",
    "SPELL_PERIODIC_AURA_BROKEN",
    "SPELL_PERIODIC_AURA_BROKEN_SPELL",
    "SPELL_PERIODIC_AURA_REMOVED",
    "SPELL_PERIODIC_AURA_REMOVED_DOSE",
}
this.endedTimestamps = {}


function this:SetupListeningTo(inputGroup)
    for i = 1, #combatLogEvents do
        InputGroupRegisterListeningTo(inputGroup,
        {
            listeningToKey = "COMBAT_LOG",
            evaluator = this,
            inputValues = { combatLogEvents[i], inputGroup.inputValues[1], inputGroup.inputValues[2] }
        })
    end
end

local function TimerStart(inputGroup, elapsedTime)
    InputGroupElapsedTimerStart(inputGroup, elapsedTime, "UNIT_AURA_ENDED_ELAPSED_TIMER_END", inputGroup.inputValues)
end

local function CalculateCurrentValue(inputGroup)
    local elapsedTime = math.huge

    local endedTimestamp = this.endedTimestamps[inputGroup.key]
    if endedTimestamp ~= nil then
        elapsedTime = GetTime() - endedTimestamp
    end

    return elapsedTime
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup)
    TimerStart(inputGroup, inputGroup.currentValue)
end

function this:GetKey(event, ...)
    local sourceUnit
    local destUnit
    local spellID

    if event == "UNIT_AURA_ENDED_ELAPSED_TIMER_END" then
        local inputValues = select(2, ...)

        sourceUnit = inputValues[1]
        destUnit = inputValues[2]
        spellID = inputValues[3]
    else -- COMBAT_LOG
        local inputGroup = ...

        sourceUnit = inputGroup.eventData.sourceUnit
        destUnit = inputGroup.eventData.destUnit
        spellID = inputGroup.eventData.spellID
    end

    return table.concat({ sourceUnit, destUnit, spellID })
end

function this:Evaluate(inputGroup, event, ...)
    local elapsedTime

    if event ~= "UNIT_AURA_ENDED_ELAPSED_TIMER_END" then -- COMBAT_LOG
        this.endedTimestamps[inputGroup.key] = GetTime()
    end

    elapsedTime = CalculateCurrentValue(inputGroup)

    if inputGroup.currentValue ~= elapsedTime then
        TimerStart(inputGroup, elapsedTime)
        inputGroup.currentValue = elapsedTime
        return true, this.key
    end
end