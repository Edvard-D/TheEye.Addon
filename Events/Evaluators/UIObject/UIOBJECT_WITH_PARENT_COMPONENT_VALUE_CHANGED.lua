TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_PARENT_COMPONENT_VALUE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_WITH_PARENT_COMPONENT_VALUE_CHANGED
this.name = "UIOBJECT_WITH_PARENT_COMPONENT_VALUE_CHANGED"

local table = table


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Parent UIObject Key# #UIOBJECT#KEY#
        #LABEL#Component Name# #COMPONENT#NAME#
        #LABEL#Value Name# #VALUE#NAME#
    }
}
]]


this.customEvents =
{
    "UIOBJECT_COMPONENT_VALUE_CHANGED",
}


function this:GetKey(event, childUIObject, component, valueName)
    if childUIObject.Child == nil then return nil end
    if component == nil then return nil end
    if component.ValueHandler[valueName] == nil then return nil end

    return table.concat({ childUIObject.Child.parentKey, component.key, valueName })
end

function this:Evaluate(inputGroup, event, childUIObject, component, valueName)
    return true, this.name, component.ValueHandler[valueName]
end