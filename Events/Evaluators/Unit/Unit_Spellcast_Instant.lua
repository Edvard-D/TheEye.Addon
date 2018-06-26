local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[unit]] "" }
TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant =
{
    gameEvents =
    {
        "UNIT_SPELLCAST_FAILED",
        "UNIT_SPELLCAST_INTERRUPTED",
        "UNIT_SPELLCAST_START",
        "UNIT_SPELLCAST_SUCCEEDED"
    },
    hasSavedValues = true
}

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:CalculateCurrentState(inputValues)
    return false
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:GetKey(event, ...)
    return table.concat({ select(1, ...) }) -- unit
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:Evaluate(savedValues, event, ...)
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        if savedValues.isCasting == false then
            return true
        end
        savedValues.isCasting = false
        return false
    elseif event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" then
        savedValues.isCasting = false
        return false
    else -- UNIT_SPELLCAST_START
        savedValues.isCasting = true
        return false
    end
end