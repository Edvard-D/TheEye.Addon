local TheEyeAddon = TheEyeAddon

local select = select


-- inputValues = { --[[addonName]] "_" }
TheEyeAddon.Events.Evaluators.Addon_Loaded =
{
    type = "STATE",
    gameEvents =
    {
        "ADDON_LOADED"
    }
}

function TheEyeAddon.Events.Evaluators.Addon_Loaded:CalculateCurrentState()
    return false
end

function TheEyeAddon.Events.Evaluators.Addon_Loaded:GetKey(event, ...)
    return select(1, ...)
end

function TheEyeAddon.Events.Evaluators.Addon_Loaded:Evaluate()
    return true
end