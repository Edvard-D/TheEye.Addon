local TheEyeAddon = TheEyeAddon


-- inputValues = nil
TheEyeAddon.Events.Evaluators.Game_Data_Loaded =
{
    type = "STATE",
    gameEvents =
    {
        "PLAYER_ENTERING_WORLD"
    }
}

function TheEyeAddon.Events.Evaluators.Game_Data_Loaded:CalculateCurrentState()
    return false
end

function TheEyeAddon.Events.Evaluators.Game_Data_Loaded:GetKey(event, ...)
    return "default"
end

function TheEyeAddon.Events.Evaluators.Game_Data_Loaded:Evaluate()
    return true
end