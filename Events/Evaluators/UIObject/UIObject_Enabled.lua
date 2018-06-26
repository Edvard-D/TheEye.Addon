local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[uiObjectKey]] "" }

 TheEyeAddon.Events.Evaluators.UIObject_Enabled =
{
    customEvents =
    {
        "THEEYE_UIOBJECT_ENABLED",
        "THEEYE_UIOBJECT_DISABLED"
    }
}

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:CalculateCurrentState(inputValues)
    local uiObject = TheEyeAddon.UI.Objects[inputValues[1]]

    if uiObject == nil then
        return false
    else
        return uiObject.StateGroups.Enabled.currentState
    end
end

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:Evaluate(savedValues, event)
    if event == "THEEYE_UIOBJECT_ENABLED" then
        return true
    else -- THEEYE_UIOBJECT_DISABLED
        return false
    end
end