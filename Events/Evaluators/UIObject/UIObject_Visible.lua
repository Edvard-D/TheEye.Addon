local TheEyeAddon = TheEyeAddon
local thisName = "UIObject_Visible"
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
    if event == "UIOBJECT_SHOWN" then
        return true
    else -- UIOBJECT_HIDDEN
        return false
    end
end