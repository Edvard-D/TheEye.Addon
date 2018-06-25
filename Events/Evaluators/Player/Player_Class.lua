local TheEyeAddon = TheEyeAddon

local select = select
local UnitClass = UnitClass


-- inputValues = { --[[englishClass]] "" }

TheEyeAddon.Events.Evaluators.Player_Class =
{
    gameEvents =
    {
        "ADDON_LOADED"
    }
}

function TheEyeAddon.Events.Evaluators.Player_Class:SetInitialState(valueGroup, inputValues)
    local _, englishClass, _ = UnitClass("player")
    return englishClass == inputValues[1]
end

function TheEyeAddon.Events.Evaluators.Player_Class:GetKey(event, ...)
    return select(2, UnitClass("player")) -- englishClass
end

function TheEyeAddon.Events.Evaluators.Player_Class:Evaluate(event, ...)
    return true
end