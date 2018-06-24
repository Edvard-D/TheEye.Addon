local TheEyeAddon = TheEyeAddon

local select = select
local table = table
local UnitCastingInfo = UnitCastingInfo


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

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active:GetKey(event, ...)
    local unit, _, spellID = ...
    return table.concat({ unit, spellID })
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active:Evaluate(event)
    if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" then
        return true
    else -- UNIT_SPELLCAST_STOP / UNIT_SPELLCAST_CHANNEL_STOP
        return false
    end
end