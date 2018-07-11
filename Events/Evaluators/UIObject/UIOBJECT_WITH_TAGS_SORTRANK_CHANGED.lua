local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_SORTRANK_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_SORTRANK_CHANGED
this.name = "UIOBJECT_WITH_TAGS_SORTRANK_CHANGED"

local UIObjectHasTags = TheEyeAddon.UI.Objects.Tags.UIObjectHasTags


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Tags# #ARRAY#TAG# }
}
]]


this.reevaluateEvents =
{
    UIOBJECT_SORTRANK_CHANGED = true,
}
this.customEvents =
{
    "UIOBJECT_SORTRANK_CHANGED",
}


function this:Evaluate(valueGroup, event, ...)
    local uiObject = ...
    local sendEvent = UIObjectHasTags(uiObject, valueGroup.inputValues, valueGroup.key)

    return sendEvent, this.name, uiObject
end