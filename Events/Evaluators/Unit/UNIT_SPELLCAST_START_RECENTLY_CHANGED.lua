local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_START_RECENTLY_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_START_RECENTLY_CHANGED
this.name = "UNIT_SPELLCAST_START_RECENTLY_CHANGED"

local GetTime = GetTime
local select = select
local StartEventTimer = TheEyeAddon.Timers.StartEventTimer
local table = table
local UnitCastingInfo = UnitCastingInfo
local unpack = unpack
local ValueGroupRegisterListeningTo = TheEyeAddon.Events.Evaluators.ValueGroupRegisterListeningTo


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spell ID# #SPELL#ID#
    }
}
]]


this.gameEvents =
{
    "UNIT_SPELLCAST_CHANNEL_START",
    "UNIT_SPELLCAST_CHANNEL_STOP",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP"
}
this.
customEvents =
{
    "UNIT_SPELLCAST_TIMER_END"
}
this.timerDuration = 0.5


function this:SetupListeningTo(valueGroup)
    ValueGroupRegisterListeningTo(valueGroup,
    {
        listeningToKey = "UNIT_SPELLCAST_INSTANT",
        evaluator = this,
        inputValues = valueGroup.inputValues
    })
end

function this:CalculateCurrentState(inputValues)
    local unit = inputValues[1]
    local expectedSpellID = inputValues[2]
    local _, _, _, startTime, _, _, castID, _, currentSpellID = UnitCastingInfo(unit)

    if currentSpellID ~= nil and currentSpellID == expectedSpellID then
        local trueStateEndTime = (startTime / 1000) + self.timerDuration
        local timerLength = trueStateEndTime - GetTime()
        if timerLength > 0 then
            StartEventTimer(self.timerDuration, "UNIT_SPELLCAST_TIMER_END", unit, currentSpellID, castID)
            return true
        end
    end

    return false
end

function this:GetKey(event, ...)
    local unit
    local spellID

    if event == "UNIT_SPELLCAST_START"
        or event == "UNIT_SPELLCAST_CHANNEL_START"
        or event == "UNIT_SPELLCAST_INSTANT"
        then
        unit, _, spellID = ...
    elseif event == "UNIT_SPELLCAST_TIMER_END" then
        _, unit, spellID = ...
    else -- UNIT_SPELLCAST_STOP / UNIT_SPELLCAST_CHANNEL_STOP
        unit, _, spellID = ...
    end
    
    return table.concat({ unit, spellID })
end

function this:Evaluate(valueGroup, event, ...)
    local spellcastStartedRecently

    if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" then
        local castID = select(7, UnitCastingInfo(valueGroup.inputValues[1]))

        spellcastStartedRecently = true
        StartEventTimer(
            self.timerDuration, "UNIT_SPELLCAST_TIMER_END", valueGroup.inputValues[1], valueGroup.inputValues[2], castID)
    elseif event == "UNIT_SPELLCAST_INSTANT" then
        spellcastStartedRecently = true
        StartEventTimer(
            self.timerDuration, "UNIT_SPELLCAST_TIMER_END", valueGroup.inputValues[1], valueGroup.inputValues[2], "INSTANT")
    elseif event == "UNIT_SPELLCAST_TIMER_END" then
        local timerDuration = select(1, ...)
        if timerDuration == self.timerDuration then
            local requiredCastID = select(4, ...)
            local castID = select(7, UnitCastingInfo(valueGroup.inputValues[1]))

            if requiredCastID == "INSTANT" or castID == requiredCastID then
                spellcastStartedRecently = false
            else
                return false
            end
        end
    else -- UNIT_SPELLCAST_STOP / UNIT_SPELLCAST_CHANNEL_STOP
        spellcastStartedRecently = false
    end

    if valueGroup.currentValue ~= spellcastStartedRecently then
        valueGroup.currentValue = spellcastStartedRecently
        return true, this.name, spellcastStartedRecently
    end
end