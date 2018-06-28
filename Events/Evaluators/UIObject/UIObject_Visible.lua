local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[uiObjectKey]] "_" }

 TheEyeAddon.Events.Evaluators.UIObject_Visible =
{
    type = "STATE",
    customEvents =
    {
        "UIOBJECT_SHOWN",
        "UIOBJECT_HIDDEN"
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

function TheEyeAddon.Events.Evaluators.UIObject_Visible:Evaluate(valueGroup, event)
    if event == "UIOBJECT_SHOWN" then
        return true
    else -- UIOBJECT_HIDDEN
        return false
    end
end