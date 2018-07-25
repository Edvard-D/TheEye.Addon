local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_PARENT_SORTRANK_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_PARENT_SORTRANK_CHANGED
this.name = "UIOBJECT_WITH_PARENT_SORTRANK_CHANGED"

local UIObjectHasTags = TheEyeAddon.Tags.UIObjectHasTags


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Tags# #ARRAY#TAG# }
}
]]


this.customEvents =
{
    "UIOBJECT_SORTRANK_CHANGED",
}


function this:GetKey(event, childUIObject)
    local childComponent = childUIObject.Child
    if childComponent == nil then
        return nil
    end

    return childComponent.parentKey
end

function this:Evaluate(inputGroup, event, childUIObject)
    return true, this.name, childUIObject
end