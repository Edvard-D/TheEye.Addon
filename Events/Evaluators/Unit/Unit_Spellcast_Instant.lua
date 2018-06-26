local TheEyeAddon = TheEyeAddon

local table = table


-- inputValues = { --[[unit]] "", --[[spellID]] 0 }
TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant =
{
    type = "EVENT",
    gameEvents =
    {
        "UNIT_SPELLCAST_START",
        "UNIT_SPELLCAST_STOP",
        "UNIT_SPELLCAST_SUCCEEDED"
    },
    hasSavedValues = true
}

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:GetKey(event, ...)
    local unit, _, spellID = ...
    return table.concat({ unit, spellID })
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:Evaluate(savedValues, event, ...)
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        if savedValues.isCasting ~= true then
            TheEyeAddon.Events.Coordinator:SendCustomEvent("UNIT_SPELLCAST_INSTANT", ...)
        end
        savedValues.isCasting = false
    elseif event == "UNIT_SPELLCAST_START" then
        savedValues.isCasting = true
    else -- UNIT_SPELLCAST_STOP
        savedValues.isCasting = false
    end
end