local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[uiObjectKey]] "_" }

 TheEyeAddon.Events.Evaluators.UIObject_Enabled =
{
    type = "STATE",
    customEvents =
    {
        "UIOBJECT_ENABLED",
        "UIOBJECT_DISABLED"
    }
}

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:CalculateCurrentState(inputValues)
    local uiObject = TheEyeAddon.UI.Objects[inputValues[1]]

    if uiObject == nil then
        return false
    else
        return uiObject.ListenerGroups.Enabled.currentState
    end
end

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:Evaluate(valueGroup, event)
    if event == "UIOBJECT_ENABLED" then
        return true
    else -- UIOBJECT_DISABLED
        return false
    end
end