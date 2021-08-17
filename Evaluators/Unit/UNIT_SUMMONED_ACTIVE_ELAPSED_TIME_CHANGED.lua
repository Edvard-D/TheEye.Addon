TheEye.Core.Evaluators.UNIT_SUMMONED_ACTIVE_ELAPSED_TIME_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_SUMMONED_ACTIVE_ELAPSED_TIME_CHANGED

local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local InputGroupDurationTimerStart = TheEye.Core.Helpers.Timers.InputGroupDurationTimerStart
local InputGroupRegisterListeningTo = TheEye.Core.Managers.Evaluators.InputGroupRegisterListeningTo
local select = select
local table = table
local timerLength = 1 -- second


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Source Unit# #UNIT#
        #LABEL#Spell ID# #SPELL#ID#
    }
}
]]

this.customEvents =
{
    "UNIT_SUMMONED_ELAPSED_TIMER_END"
}
local combatLogEvents =
{
    "SPELL_SUMMON",
    "UNIT_DESTROYED",
    "UNIT_DIED",
    "UNIT_DISSIPATES",
}


function this:SetupListeningTo(inputGroup)
    for i = 1, #combatLogEvents do
        InputGroupRegisterListeningTo(inputGroup,
        {
            listeningToKey = "COMBAT_LOG",
            evaluator = this,
            inputValues = { combatLogEvents[i], "_", "_" }
        })
    end
end

local function TimerStart(inputGroup)
    InputGroupDurationTimerStart(inputGroup, timerLength, "UNIT_SUMMONED_ELAPSED_TIMER_END", inputGroup.inputValues)
end

local function CalculateCurrentValue(inputGroup)
    return GetTime() - inputGroup.elapsedTimeStartTimestamp
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = 0
end

function this:GetKey(event, ...)
    local sourceUnit
    local spellID

    if event == "UNIT_SUMMONED_ELAPSED_TIMER_END" then
        local inputValues = select(2, ...)
        sourceUnit = inputValues[1]
        spellID = inputValues[2]
    else -- COMBAT_LOG
        eventData = eventInputGroup.eventData
        local combatLogSpellName = select(1, GetSpellInfo(eventData.spellID))

        for i = 1, #self.InputGroups do
            local inputValues = self.InputGroups[i].inputValues
            local inputGroupSourceUnit = inputValues[1]
            local inputGroupSpellID = inputValues[2]
            local inputGroupSpellName = select(1, GetSpellInfo(inputGroupSpellID))

            if inputGroupSourceUnit == eventData.sourceUnit and inputGroupSpellName == combatLogSpellName then
                if sourceUnit ~= nil and spellID ~= nil then
                    error("More than one input group matches for inputValues[1] of " .. tostring(inputValues[1]) ..
                        " and inputValues[2] of " .. tostring(inputValues[2]) .. ".")
                end
                
                sourceUnit = inputGroupSourceUnit
                spellID = inputGroupSpellID
            end
        end
    end
    
    return table.concat({ sourceUnit, spellID })
end

function this:Evaluate(inputGroup, event, ...)
    local elapsedTime = 0

    if event == "SPELL_SUMMON" then
        inputGroup.elapsedTimeStartTimestamp = GetTime()
        inputGroup.isAlive = true
        TimerStart(inputGroup)
    elseif event == "UNIT_SUMMONED_ELAPSED_TIMER_END" then
        if inputGroup.isAlive == true then
            TimerStart(inputGroup)
            elapsedTime = CalculateCurrentValue(inputGroup)
        end
    else -- UNIT_DESTROYED, UNIT_DIED, UNIT_DISSIPATES
        inputGroup.isAlive = false
    end

    if inputGroup.currentValue ~= elapsedTime then
        TimerStart(inputGroup, elapsedTime)
        inputGroup.currentValue = elapsedTime
        return true, this.key
    end
end