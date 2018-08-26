TheEyeAddon.Evaluators.UIOBJECT_SIZE_CHANGED = {}
local this = TheEyeAddon.Evaluators.UIOBJECT_SIZE_CHANGED


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


this.customEvents =
{
    "UIOBJECT_RESIZED",
}


function this:GetKey(event, uiObject)
    return uiObject.key
end

function this:Evaluate(inputGroup, event, uiObject)
    inputGroup.currentValue = uiObject
    return true, this.key
end