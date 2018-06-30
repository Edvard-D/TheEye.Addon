local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[uiObjectKey]] "_" }
TheEyeAddon.Events.Evaluators.Module_Enabled =
{
    type = "STATE",
    reevaluateEvents =
    {
        ADDON_LOADED = true
    },
    gameEvents =
    {
        "ADDON_LOADED"
    },
    customEvents =
    {
        "SETTING_CHANGED"
    }
}

function TheEyeAddon.Events.Evaluators.Module_Enabled:CalculateCurrentState(inputValues)
    if TheEyeAddon.Settings ~= nil
            and table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, inputValues[1]) == false then
        return true
    else
        return false
    end
end

function TheEyeAddon.Events.Evaluators.Module_Enabled:GetKey(event, ...)
    return select(1, ...) -- SETTING_CHANGED: moduleKey
end

function TheEyeAddon.Events.Evaluators.Module_Enabled:Evaluate(valueGroup, event, ...)
    return TheEyeAddon.Events.Evaluators.Module_Enabled:CalculateCurrentState(valueGroup.inputValues)
end