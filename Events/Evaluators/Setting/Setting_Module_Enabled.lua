local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[moduleKey]] "" }

TheEyeAddon.Events.Evaluators.Setting_Module_Enabled =
{
    customEvents =
    {
        "THEEYE_SETTING_CHANGED"
    }
}

function TheEyeAddon.Events.Evaluators.Setting_Module_Enabled:SetInitialState(valueGroup, inputValues)
    if TheEyeAddon.Settings == nil or table.hasvalue(TheEyeAddon.Settings.DisabledUIModules, inputValues[1]) == false then
        valueGroup.currentState = true
    else
        valueGroup.currentState = false
    end
end

function TheEyeAddon.Events.Evaluators.Setting_Module_Enabled:GetKey(event, ...)
    return select(1, ...) -- moduleKey
end

function TheEyeAddon.Events.Evaluators.Setting_Module_Enabled:Evaluate(event)
    return select(2, ...) -- enabledState
end