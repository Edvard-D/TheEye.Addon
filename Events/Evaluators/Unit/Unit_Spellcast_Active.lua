local TheEyeAddon = TheEyeAddon

local select = select


-- inputValues = { --[[unit]] "", --[[spellID]] 0 }
TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active =
{
    gameEvents =
    {
        "UNIT_SPELLCAST_CHANNEL_START",
        "UNIT_SPELLCAST_CHANNEL_STOP",
        "UNIT_SPELLCAST_START",
        "UNIT_SPELLCAST_STOP"
    }
}

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active:SetInitialState(valueGroup, inputValues)
    local expectedSpellID = inputValues[2]
    local currentSpellID = select(9, UnitCastingInfo(inputValues[1]))

    if currentSpellID == expectedSpellID then
        valueGroup.currentState = true
    else
        valueGroup.currentState = false
    end
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active:Evaluate(event, ...)
    local unit, _, spellID = ...
    
    if event == "UNIT_SPELLCAST_START" or "UNIT_SPELLCAST_CHANNEL_START" then
        return table.concat({ unit, spellID }), true
    else -- UNIT_SPELLCAST_STOP / UNIT_SPELLCAST_CHANNEL_STOP
        return table.concat({ unit, spellID }), false
    end
end