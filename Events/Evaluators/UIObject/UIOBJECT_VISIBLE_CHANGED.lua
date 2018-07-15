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


function this:CalculateCurrentValue(inputValues)
    local uiObject = TheEyeAddon.UI.Objects[inputValues[1]]

    if uiObject == nil or uiObject.VisibleState == nil then
        return false
    else
        return uiObject.VisibleState.ValueHandler.state
    end
end

function this:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function this:Evaluate(inputGroup, event)
    local isVisible = event == "UIOBJECT_SHOWN" -- else UIOBJECT_HIDDEN

    if inputGroup.currentValue ~= isVisible then
        inputGroup.currentValue = isVisible
        return true, this.name, isVisible
    end
end