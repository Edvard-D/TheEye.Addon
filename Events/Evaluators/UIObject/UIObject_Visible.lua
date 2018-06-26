local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[uiObjectKey]] "" }

 TheEyeAddon.Events.Evaluators.UIObject_Visible =
{
    type = "STATE",
    customEvents =
    {
        "THEEYE_UIOBJECT_SHOWN",
        "THEEYE_UIOBJECT_HIDDEN"
    }
}

function TheEyeAddon.Events.Evaluators.UIObject_Visible:CalculateCurrentState(inputValues)
    local uiObject = TheEyeAddon.UI.Objects[inputValues[1]]

    if uiObject == nil then
        return false
    else
        return uiObject.StateGroups.Visible.currentState
    end
end

function TheEyeAddon.Events.Evaluators.UIObject_Visible:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function TheEyeAddon.Events.Evaluators.UIObject_Visible:Evaluate(savedValues, event)
    if event == "THEEYE_UIOBJECT_SHOWN" then
        return true
    else -- THEEYE_UIOBJECT_HIDDEN
        return false
    end
end