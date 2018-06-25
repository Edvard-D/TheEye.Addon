local TheEyeAddon = TheEyeAddon

local GetSpecialization = GetSpecialization
local select = select


-- inputValues = { --[[specNumber]] 0 }

TheEyeAddon.Events.Evaluators.Player_Spec =
{
    gameEvents =
    {
        "ACTIVE_TALENT_GROUP_CHANGED",
        "ADDON_LOADED"
    }
}

function TheEyeAddon.Events.Evaluators.Player_Spec:SetInitialState(valueGroup, inputValues)
    return inputValues[1] == GetSpecialization()
end

function TheEyeAddon.Events.Evaluators.Player_Spec:GetKey(event, ...)
    return GetSpecialization()
end

function TheEyeAddon.Events.Evaluators.Player_Spec:Evaluate(event, ...)
    return true
end