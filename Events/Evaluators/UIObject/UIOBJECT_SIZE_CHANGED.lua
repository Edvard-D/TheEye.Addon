TheEyeAddon.Events.Evaluators.UIOBJECT_SIZE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_SIZE_CHANGED


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

function this:Evaluate(inputGroup, uiObject)
    return true, this.key, uiObject
end