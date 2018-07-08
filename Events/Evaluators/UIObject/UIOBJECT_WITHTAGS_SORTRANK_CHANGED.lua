local TheEyeAddon = TheEyeAddon
local thisName = "UIOBJECT_WITHTAGS_SORTRANK_CHANGED"
local this = TheEyeAddon.Events.Evaluators[thisName]

local UIObjectHasTags = TheEyeAddon.UI.Objects.Tags.UIObjectHasTags


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Tags# #ARRAY#TAG# }
}
]]


this.type = "EVENT"
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

    return sendEvent, thisName, uiObject
end