local TheEyeAddon = TheEyeAddon

local table = table


-- inputValues = { --[[unit]] "", --[[spellID]] 0 }
TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant =
{
    gameEvents =
    {
        "UNIT_SPELLCAST_START",
        "UNIT_SPELLCAST_STOP",
        "UNIT_SPELLCAST_SUCCEEDED"
    },
    hasSavedValues = true
}

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:CalculateCurrentState(inputValues)
    return false
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:GetKey(event, ...)
    local unit, _, spellID = ...
    return table.concat({ unit, spellID })
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:Evaluate(savedValues, event, ...)
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        if savedValues.isCasting == false then
            return true
        end
        savedValues.isCasting = false
        return false
    elseif event == "UNIT_SPELLCAST_START" then
        savedValues.isCasting = true
        return false
    else -- UNIT_SPELLCAST_STOP
        savedValues.isCasting = false
        return false
    end
end