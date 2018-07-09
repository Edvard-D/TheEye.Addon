local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_INITIALIZED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_INITIALIZED

local UIObjectHasTags = TheEyeAddon.UI.Objects.Tags.UIObjectHasTags


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Tags# #ARRAY#TAG# }
}
]]


this.type = "EVENT"
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


function this:Evaluate(valueGroup, event, ...)
    local uiObject = ...
    local sendEvent = UIObjectHasTags(uiObject, valueGroup.inputValues, valueGroup.key)

    return sendEvent, thisName, uiObject
end