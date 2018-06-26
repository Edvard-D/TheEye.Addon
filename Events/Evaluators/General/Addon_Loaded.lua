local TheEyeAddon = TheEyeAddon

local select = select


-- inputValues = { --[[addonName]] "" }

TheEyeAddon.Events.Evaluators.Addon_Loaded =
{
    gameEvents =
    {
        "ADDON_LOADED"
    }
}

function TheEyeAddon.Events.Evaluators.Addon_Loaded:CalculateCurrentState(inputValues)
    return false
end

function TheEyeAddon.Events.Evaluators.Addon_Loaded:GetKey(event, ...)
    return select(1, ...)
end

function TheEyeAddon.Events.Evaluators.Addon_Loaded:Evaluate(savedValues, event, ...)
    return true
end