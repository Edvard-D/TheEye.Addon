local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_SORTRANK_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_SORTRANK_CHANGED
this.name = "UIOBJECT_WITH_TAGS_SORTRANK_CHANGED"

local UIObjectHasTags = TheEyeAddon.Tags.UIObjectHasTags


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


function this:Evaluate(inputGroup, event, ...)
    local uiObject = ...
    local sendEvent = UIObjectHasTags(uiObject, inputGroup.inputValues, inputGroup.key)

    return sendEvent, this.name, uiObject
end