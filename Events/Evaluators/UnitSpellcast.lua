local TheEyeAddon = TheEyeAddon

local select = select


TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active =
{
    gameEvents = { "UNIT_SPELLCAST_START", "UNIT_SPELLCAST_STOP" },
    Evaluate = function(event, ...)
        local unit, _, spellID = ...
        
        if event == "UNIT_SPELLCAST_START" then
            return table.concat({ unit, spellID }), true
        else -- UNIT_SPELLCAST_STOP
            return table.concat({ unit, spellID }), false
        end
    end,
    SetInitialState = function(self, valueGroup, inputValues)
        local expectedSpellID = inputValues[2]
        local currentSpellID = select(9, UnitCastingInfo(inputValues[1]))

        if currentSpellID == expectedSpellID then
            valueGroup.currentState = true
        else
            valueGroup.currentState = false
        end
    end
}

TheEyeAddon.Events.Evaluators.Unit_Spellcast_StartedRecently =
{
    gameEvents = { "UNIT_SPELLCAST_START", "UNIT_SPELLCAST_STOP" },
    customEvents = { "THEEYE_UNIT_SPELLCAST_TIMER_END" },
    castLength = 0.5,
    Evaluate = function(event, ...)
        if event == "UNIT_SPELLCAST_START" then
            local unit, _, spellID = ...
            local castID = select(7, UnitCastingInfo(unit))

            TheEyeAddon.Timers:StartEventTimer(self.castLength, "THEEYE_UNIT_SPELLCAST_TIMER_END", unit, spellID, castID)
            return table.concat({ unit, spellID }), true
        elseif event == "THEEYE_UNIT_SPELLCAST_TIMER_END" then
            local timerDuration = select(4, ...)
            if timerDuration == self.castLength then
                local unit, requiredSpellID, requiredCastID = ...
                local _, _, _, _, _, _, castID, _, spellID = UnitCastingInfo(unit)

                if castID == requiredCastID then
                    return table.concat({ unit, spellID }), false
                end
            end
        else -- UNIT_SPELLCAST_STOP
            local unit, _, spellID = ...
            return table.concat({ unit, spellID }), false
        end
    end,
    SetInitialState = function(self, valueGroup, inputValues)
        local unit = inputValues[1]
        local expectedSpellID = inputValues[2]
        local _, _, _, startTime, _, _, castID, _, currentSpellID = UnitCastingInfo(unit)
        local trueStateEndTime = (startTime / 1000) + self.castLength
        local timerLength = trueStateEndTime - GetTime()

        if currentSpellID == expectedSpellID and timerLength > 0 then
            TheEyeAddon.Timers:StartEventTimer(self.castLength, "THEEYE_UNIT_SPELLCAST_TIMER_END", unit, currentSpellID, castID)
            valueGroup.currentState = true
        else
            valueGroup.currentState = false
        end
    end
}