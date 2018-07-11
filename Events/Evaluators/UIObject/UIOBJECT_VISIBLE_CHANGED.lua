local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_VISIBLE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_VISIBLE_CHANGED
this.name = "UIOBJECT_VISIBLE_CHANGED"

local select = select


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


this.customEvents =
{
    "UIOBJECT_HIDDEN",
    "UIOBJECT_SHOWN",
}


function this:CalculateCurrentState(inputValues)
    local uiObject = TheEyeAddon.UI.Objects[inputValues[1]]

    if uiObject == nil then
        return false
    else
        return uiObject.ListenerGroups.Visible.currentState
    end
end

function this:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function this:Evaluate(valueGroup, event)
    local isVisible = event == "UIOBJECT_SHOWN" -- else UIOBJECT_HIDDEN

    if valueGroup.currentState ~= isVisible then
        valueGroup.currentState = isVisible
        return true, this.name, isVisible
    end
end