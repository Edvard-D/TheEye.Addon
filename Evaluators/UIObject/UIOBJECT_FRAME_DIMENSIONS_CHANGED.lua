TheEye.Core.Evaluators.UIOBJECT_FRAME_DIMENSIONS_CHANGED = {}
local this = TheEye.Core.Evaluators.UIOBJECT_FRAME_DIMENSIONS_CHANGED


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


this.customEvents =
{
    "UIOBJECT_FRAME_DIMENSIONS_CHANGED",
}


function this:GetKey(event, uiObject)
    return uiObject.key
end

function this:Evaluate(inputGroup, event, uiObject)
    inputGroup.currentValue = uiObject
    return true, this.key
end