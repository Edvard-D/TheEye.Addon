TheEyeAddon.Evaluators.UIOBJECT_WITH_TAGS_SIZE_CHANGED = {}
local this = TheEyeAddon.Evaluators.UIOBJECT_WITH_TAGS_SIZE_CHANGED

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
    inputGroup.currentValue = uiObject
    return sendEvent, this.key
end