local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_VISIBLE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_VISIBLE_CHANGED
this.name = "UIOBJECT_VISIBLE_CHANGED"


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


local function CalculateCurrentValue(uiObject)
    if uiObject == nil then
        return false
    else
        return uiObject.VisibleState.ValueHandler.state or false
    end
end

function this:InputGroupSetup(inputGroup)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputValues[1]]
    inputGroup.currentValue = CalculateCurrentValue(uiObject)
end

function this:GetKey(event, uiObject)
    return uiObject.key
end

function this:Evaluate(inputGroup, event, uiObject)
    local isVisible = CalculateCurrentValue(uiObject)

    if inputGroup.currentValue ~= isVisible then
        inputGroup.currentValue = isVisible
        return true, this.name, isVisible
    end
end