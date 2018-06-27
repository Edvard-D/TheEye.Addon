local TheEyeAddon = TheEyeAddon

local select = select
local UnitClass = UnitClass


-- inputValues = { --[[classIndex]] 0 }

TheEyeAddon.Events.Evaluators.Player_Class =
{
    type = "STATE",
    gameEvents =
    {
        "ADDON_LOADED"
    }
}

function TheEyeAddon.Events.Evaluators.Player_Class:CalculateCurrentState(inputValues)
    local classIndex = select(3, UnitClass("player"))
    return classIndex == inputValues[1]
end

function TheEyeAddon.Events.Evaluators.Player_Class:GetKey()
    return select(3, UnitClass("player")) -- classIndex
end

function TheEyeAddon.Events.Evaluators.Player_Class:Evaluate()
    return true
end