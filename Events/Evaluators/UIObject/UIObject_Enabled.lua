local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[tags]] , }

 TheEyeAddon.Events.Evaluators.UIObject_Enabled =
{
    customEvents =
    {
        "THEEYE_UIOBJECT_ENABLED",
        "THEEYE_UIOBJECT_DISABLED"
    }
}

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:SetInitialState(valueGroup, inputValues)
    local uiObject = TheEyeAddon.UI.Objects[table.concat(iputValues, "-")]

    if uiObject == nil then
        valueGroup.currentState = false
    else
        valueGroup.currentState = uiObject.StateGroups.Enabled.currentState
    end
end

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function TheEyeAddon.Events.Evaluators.UIObject_Enabled:Evaluate(event)
    if event == "THEEYE_UIOBJECT_ENABLED" then
        return true
    else -- THEEYE_UIOBJECT_DISABLED
        return false
    end
end