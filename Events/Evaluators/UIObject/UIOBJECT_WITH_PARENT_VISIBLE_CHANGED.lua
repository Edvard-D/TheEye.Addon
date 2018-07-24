local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_PARENT_VISIBLE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_PARENT_VISIBLE_CHANGED
this.name = "UIOBJECT_WITH_PARENT_VISIBLE_CHANGED"


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Parent UIObject# #UIOBJECT#KEY# }
}
]]


this.customEvents =
{
    "UIOBJECT_HIDDEN",
    "UIOBJECT_SHOWN",
}


function this:GetKey(event, childUIObject)
    local parentComponent = childUIObject.Parent
    if parentComponent == nil then
        return nil
    end

    return parentComponent.key
end

function this:Evaluate(inputGroup, event, childUIObject)
    return true, this.name, childUIObject
end