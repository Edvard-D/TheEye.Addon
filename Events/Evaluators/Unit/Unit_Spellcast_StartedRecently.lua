local TheEyeAddon = TheEyeAddon

local GetTime = GetTime
local select = select
local table = table
local UnitCastingInfo = UnitCastingInfo


-- inputValues = { --[[unit]] "", --[[spellID]] 0 }
TheEyeAddon.Events.Evaluators.Unit_Spellcast_StartedRecently =
{
    gameEvents =
    {
        "UNIT_SPELLCAST_CHANNEL_START",
        "UNIT_SPELLCAST_CHANNEL_STOP",
        "UNIT_SPELLCAST_START",
        "UNIT_SPELLCAST_STOP"
    },
    customEvents =
    {
        "THEEYE_UNIT_SPELLCAST_TIMER_END"
    },
    castLength = 0.5
}

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_StartedRecently:SetInitialState(valueGroup, inputValues)
    local unit = inputValues[1]
    local expectedSpellID = inputValues[2]
    local _, _, _, startTime, _, _, castID, _, currentSpellID = UnitCastingInfo(unit)

    if currentSpellID ~= nil and currentSpellID == expectedSpellID then
        local trueStateEndTime = (startTime / 1000) + self.castLength
        local timerLength = trueStateEndTime - GetTime()
        if timerLength > 0 then
            TheEyeAddon.Timers:StartEventTimer(self.castLength, "THEEYE_UNIT_SPELLCAST_TIMER_END", unit, currentSpellID, castID)
            valueGroup.currentState = true
            return
        end
    end

    valueGroup.currentState = false
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_StartedRecently:GetKey(event, ...)
    local unit
    local spellID

    if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" then
        local unit, _, spellID = ...
    elseif event == "THEEYE_UNIT_SPELLCAST_TIMER_END" then
        local unit, spellID, _ = ...
    else -- UNIT_SPELLCAST_STOP / UNIT_SPELLCAST_CHANNEL_STOP
        local unit, _, spellID = ...
    end
    
    return table.concat({ unit, spellID })
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_StartedRecently:Evaluate(event, ...)
    if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" then
        local unit, _, spellID = ...
        local castID = select(7, UnitCastingInfo(unit))

        TheEyeAddon.Timers:StartEventTimer(self.castLength, "THEEYE_UNIT_SPELLCAST_TIMER_END", unit, spellID, castID)
        return true
    elseif event == "THEEYE_UNIT_SPELLCAST_TIMER_END" then
        local timerDuration = select(4, ...)
        if timerDuration == self.castLength then
            local unit, _, requiredCastID = ...
            local castID = select(7, UnitCastingInfo(unit))

            if castID == requiredCastID then
                return false
            end
        end
    else -- UNIT_SPELLCAST_STOP / UNIT_SPELLCAST_CHANNEL_STOP
        return false
    end
end