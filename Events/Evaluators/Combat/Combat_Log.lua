local TheEyeAddon = TheEyeAddon

local table = table


-- inputValues = { --[[eventName]] "" }
TheEyeAddon.Events.Evaluators.Combat_Log =
{
    type = "EVENT",
    gameEvents =
    {
        "COMBAT_LOG_EVENT_UNFILTERED"
    }
}

function TheEyeAddon.Events.Evaluators.Combat_Log:GetKey(event, ...)
    return select(2, ...)
end

function TheEyeAddon.Events.Evaluators.Combat_Log:Evaluate(savedValues, event, ...)
    TheEyeAddon.Events.Coordinator:SendCustomEvent(select(2, ...), ...)
end