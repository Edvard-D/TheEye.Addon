local TheEyeAddon = TheEyeAddon
local thisName = "UIOBJECT_WITHTAGS_VISIBILE_CHANGED"
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
    UIOBJECT_HIDDEN = true,
    UIOBJECT_SHOWN = true,
}
this.customEvents =
{
    "UIOBJECT_HIDDEN",
    "UIOBJECT_SHOWN",
}


function this:Evaluate(valueGroup, event, ...)
    local uiObject = ...
    local hasTags = UIObjectHasTags(uiObject, valueGroup.inputValues, valueGroup.key)

    return hasTags, thisName, uiObject
end