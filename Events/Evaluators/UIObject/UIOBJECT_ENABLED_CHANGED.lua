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


function this:CalculateCurrentState(inputValues)
    local uiObject = TheEyeAddon.UI.Objects[inputValues[1]]

    if uiObject == nil then
        return false
    else
        return uiObject.ListenerGroups.Enabled.currentState
    end
end

function this:GetKey(event, ...)
    local uiObject = select(1, ...)
    return uiObject.key
end

function this:Evaluate(inputGroup, event)
    local isEnabled = event == "UIOBJECT_ENABLED" -- else UIOBJECT_DISABLED

    if inputGroup.currentState ~= isEnabled then
        inputGroup.currentState = isEnabled
        return true, this.name, isEnabled
    end
end