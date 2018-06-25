local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[englishClass]] "" }

TheEyeAddon.Events.Evaluators.Player_Class =
{
    gameEvents =
    {
        "ADDON_LOADED"
    }
}

function TheEyeAddon.Events.Evaluators.Addon_Loaded:SetInitialState(valueGroup, inputValues)
    local _, englishClass, _ = UnitClass("player")
    return englishClass == inputValues[1]
end

function TheEyeAddon.Events.Evaluators.Addon_Loaded:GetKey(event, ...)
    return select(2, UnitClass("player")) -- englishClass
end

function TheEyeAddon.Events.Evaluators.Addon_Loaded:Evaluate(event, ...)
    return true
end