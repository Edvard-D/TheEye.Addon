local TheEyeAddon = TheEyeAddon

local GetInspectSpecialization = GetInspectSpecialization
local GetSpecialization = GetSpecialization
local GetSpecializationInfo = GetSpecializationInfo
local select = select


-- inputValues = { --[[unit]] "_", --[[specID]] 0 }
--      unit: required
--      specID: required
TheEyeAddon.Events.Evaluators.Unit_Spec =
{
    type = "STATE",
    reevaluateEvents =
    {
        PLAYER_TARGET_CHANGED = true
    },
    gameEvents =
    {
        "ACTIVE_TALENT_GROUP_CHANGED",
        "PLAYER_TARGET_CHANGED"
    }
}

function TheEyeAddon.Events.Evaluators.Unit_Spec:CalculateCurrentState(inputValues)
    local specID

    if inputValues[1] == "player" then
        specID = GetSpecializationInfo(GetSpecialization())
    else
        specID = GetInspectSpecialization(inputValues[1])
    end

    return inputValues[2] == specID
end

function TheEyeAddon.Events.Evaluators.Unit_Spec:GetKey(event, ...) -- doesn't get called on PLAYER_TARGET_CHANGED
    return table.concat({ "player", select(1, GetSpecializationInfo(GetSpecialization())) })
end

function TheEyeAddon.Events.Evaluators.Unit_Spec:Evaluate(valueGroup, event)
    if self.reevaluateEvents[event] == true then
        return TheEyeAddon.Events.Evaluators.Unit_Spec:CalculateCurrentState(valueGroup.inputValues)
    else -- ACTIVE_TALENT_GROUP_CHANGED
        return true
    end
end