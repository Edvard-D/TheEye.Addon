TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_INITIALIZED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_INITIALIZED

local UIObjectHasTags = TheEyeAddon.Tags.UIObjectHasTags


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
    return sendEvent, this.key, uiObject
end