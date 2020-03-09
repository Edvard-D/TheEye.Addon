TheEye.Core.Evaluators.UIOBJECT_WITH_TAGS_INITIALIZED = {}
local this = TheEye.Core.Evaluators.UIOBJECT_WITH_TAGS_INITIALIZED

local UIObjectHasTags = TheEye.Core.Tags.UIObjectHasTags


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Tags# #ARRAY#TAG# }
}
]]


reevaluateEvents =
{
    UIOBJECT_HIDDEN = true,
    UIOBJECT_SHOWN = true,
}
customEvents =
{
    "UIOBJECT_HIDDEN",
    "UIOBJECT_SHOWN",
}


function this:Evaluate(inputGroup, event, uiObject)
    local sendEvent = UIObjectHasTags(uiObject, inputGroup.inputValues, inputGroup.key)
    inputGroup.currentValue = uiObject
    return sendEvent, this.key
end