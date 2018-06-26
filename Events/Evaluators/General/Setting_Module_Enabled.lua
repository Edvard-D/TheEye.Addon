local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[moduleKey]] "" }

TheEyeAddon.Events.Evaluators.Setting_Module_Enabled =
{
    type = "STATE",
    customEvents =
    {
        "THEEYE_SETTING_CHANGED"
    }
}

function TheEyeAddon.Events.Evaluators.Setting_Module_Enabled:CalculateCurrentState(inputValues)
    if TheEyeAddon.Settings == nil or table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, inputValues[1]) == false then
        return true
    else
        return false
    end
end

function TheEyeAddon.Events.Evaluators.Setting_Module_Enabled:GetKey(event, ...)
    return select(1, ...) -- moduleKey
end

function TheEyeAddon.Events.Evaluators.Setting_Module_Enabled:Evaluate(savedValues, event, ...)
    return select(2, ...) -- enabledState
end