TheEyeAddon.Evaluators.UIOBJECT_WITH_TAGS_SORTRANK_CHANGED = {}
local this = TheEyeAddon.Evaluators.UIOBJECT_WITH_TAGS_SORTRANK_CHANGED

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


function this:Evaluate(inputGroup, event, uiObject)
    local sendEvent = UIObjectHasTags(uiObject, inputGroup.inputValues, inputGroup.key)
    inputGroup.currentValue = uiObject
    return sendEvent, this.key
end