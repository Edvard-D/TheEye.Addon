local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_SIZE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_TAGS_SIZE_CHANGED
this.name = "UIOBJECT_WITH_TAGS_SIZE_CHANGED"

local UIObjectHasTags = TheEyeAddon.Tags.UIObjectHasTags


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Tags# #ARRAY#TAG# }
}
]]


this.reevaluateEvents =
{
    UIOBJECT_RESIZED = true,
}
this.customEvents =
{
    "UIOBJECT_RESIZED",
}


function this:Evaluate(inputGroup, event, uiObject)
    local sendEvent = UIObjectHasTags(uiObject, inputGroup.inputValues, inputGroup.key)
    return sendEvent, this.name, uiObject
end