local TheEyeAddon = TheEyeAddon

local GetSpecialization = GetSpecialization
local select = select


-- inputValues = { --[[specNumber]] 0 }

TheEyeAddon.Events.Evaluators.Player_Spec =
{
    type = "STATE",
    gameEvents =
    {
        "ACTIVE_TALENT_GROUP_CHANGED",
        "ADDON_LOADED"
    }
}

function TheEyeAddon.Events.Evaluators.Player_Spec:CalculateCurrentState(inputValues)
    return inputValues[1] == GetSpecialization()
end

function TheEyeAddon.Events.Evaluators.Player_Spec:GetKey(event, ...)
    return GetSpecialization()
end

function TheEyeAddon.Events.Evaluators.Player_Spec:Evaluate(savedValues, event, ...)
    return true
end