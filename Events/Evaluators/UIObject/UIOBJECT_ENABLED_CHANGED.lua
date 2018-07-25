local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_ENABLED_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_ENABLED_CHANGED
this.name = "UIOBJECT_ENABLED_CHANGED"


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


this.customEvents =
{
    "UIOBJECT_ENABLED",
    "UIOBJECT_DISABLED"
}


local function CalculateCurrentValue(uiObject)
    return uiObject.EnabledState.ValueHandler.state or false
end

function this:InputGroupSetup(inputGroup)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputGroup.inputValues[1]]
    inputGroup.currentValue = CalculateCurrentValue(uiObject)
end

function this:GetKey(event, uiObject)
    return uiObject.key
end

function this:Evaluate(inputGroup, event, uiObject)
    local isEnabled = CalculateCurrentValue(uiObject)

    if inputGroup.currentValue ~= isEnabled then
        inputGroup.currentValue = isEnabled
        return true, this.name, isEnabled
    end
end