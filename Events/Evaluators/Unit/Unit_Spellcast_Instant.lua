local TheEyeAddon = TheEyeAddon

local table = table


-- inputValues = { --[[unit]] "_", --[[spellID]] 0 }
TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant =
{
    type = "EVENT",
    gameEvents =
    {
        "UNIT_SPELLCAST_START",
        "UNIT_SPELLCAST_STOP",
        "UNIT_SPELLCAST_SUCCEEDED"
    }
}

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:GetKey(event, ...)
    local unit, _, spellID = ...
    return table.concat({ unit, spellID })
end

function TheEyeAddon.Events.Evaluators.Unit_Spellcast_Instant:Evaluate(valueGroup, event, ...)
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        if valueGroup.isCasting ~= true then
            return true, "UNIT_SPELLCAST_INSTANT", ...
        end
        valueGroup.isCasting = false
    elseif event == "UNIT_SPELLCAST_START" then
        valueGroup.isCasting = true
    else -- UNIT_SPELLCAST_STOP
        valueGroup.isCasting = false
    end

    return false
end