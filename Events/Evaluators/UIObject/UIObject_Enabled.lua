local TheEyeAddon = TheEyeAddon
local thisName = "UIObject_Enabled"
local this = TheEyeAddon.Events.Evaluators[thisName]

local select = select


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


this.type = "STATE"
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

function this:Evaluate(valueGroup, event)
    if event == "UIOBJECT_ENABLED" then
        return true
    else -- UIOBJECT_DISABLED
        return false
    end
end