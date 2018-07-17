local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_ENABLED_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_ENABLED_CHANGED
this.name = "UIOBJECT_ENABLED_CHANGED"

local select = select


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


local function CalculateCurrentValue(inputValues)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputValues[1]]

    if uiObject == nil then
        return false
    else
        return uiObject.EnabledState.ValueHandler.state or false
    end
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function this:Evaluate(inputGroup, event)
    local isEnabled = event == "UIOBJECT_ENABLED" -- else UIOBJECT_DISABLED

    if inputGroup.currentValue ~= isEnabled then
        inputGroup.currentValue = isEnabled
        return true, this.name, isEnabled
    end
end