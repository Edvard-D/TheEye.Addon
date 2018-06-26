local TheEyeAddon = TheEyeAddon

local select = select
local table = table
local UnitCastingInfo = UnitCastingInfo


-- inputValues = { --[[unit]] "", --[[spellID]] 0 }
TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active =
{
    type = "STATE",
    gameEvents =
    {
        "UNIT_SPELLCAST_CHANNEL_START",
        "UNIT_SPELLCAST_CHANNEL_STOP",
        "UNIT_SPELLCAST_START",
        "UNIT_SPELLCAST_STOP"
    }
}

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active:CalculateCurrentState(inputValues)
    local expectedSpellID = inputValues[2]
    local currentSpellID = select(9, UnitCastingInfo(inputValues[1]))

    if currentSpellID == expectedSpellID then
        return true
    else
        return false
    end
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active:GetKey(event, ...)
    local unit, _, spellID = ...
    return table.concat({ unit, spellID })
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Active:Evaluate(savedValues, event)
    if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" then
        return true
    else -- UNIT_SPELLCAST_STOP / UNIT_SPELLCAST_CHANNEL_STOP
        return false
    end
end