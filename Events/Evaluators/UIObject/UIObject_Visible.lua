local TheEyeAddon = TheEyeAddon

local select = select
local table = table


-- inputValues = { --[[tags]] , }

 TheEyeAddon.Events.Evaluators.UIObject_Visible =
{
    customEvents =
    {
        "THEEYE_UIOBJECT_SHOWN",
        "THEEYE_UIOBJECT_HIDDEN"
    }
}

function TheEyeAddon.Events.Evaluators.UIObject_Visible:SetInitialState(valueGroup, inputValues)
    local uiObject = TheEyeAddon.UI.Objects[table.concat(iputValues, "_")]

    if uiObject == nil then
        valueGroup.currentState = false
    else
        valueGroup.currentState = uiObject.StateGroups.Visible.currentState
    end
end

function TheEyeAddon.Events.Evaluators.UIObject_Visible:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function TheEyeAddon.Events.Evaluators.UIObject_Visible:Evaluate(event)
    if event == "THEEYE_UIOBJECT_SHOWN" then
        return true
    else -- THEEYE_UIOBJECT_HIDDEN
        return false
    end
end