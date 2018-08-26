TheEyeAddon.Evaluators.UIOBJECT_WITH_PARENT_COMPONENT_VALUE_CHANGED = {}
local this = TheEyeAddon.Evaluators.UIOBJECT_WITH_PARENT_COMPONENT_VALUE_CHANGED

local table = table


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Parent UIObject Key# #UIOBJECT#KEY#
        #LABEL#Component Key# #COMPONENT#KEY#
        #LABEL#Value Key# #VALUE#KEY#
    }
}
]]


this.customEvents =
{
    "UIOBJECT_COMPONENT_VALUE_CHANGED",
}


function this:GetKey(event, childUIObject, component, valueKey)
    if childUIObject.Child == nil then return nil end
    if component == nil then return nil end
    if component.ValueHandler[valueKey] == nil then return nil end

    return table.concat({ childUIObject.Child.parentKey, component.key, valueKey })
end

function this:Evaluate(inputGroup, event, childUIObject, component, valueKey)
    inputGroup.currentValue = component.ValueHandler[valueKey]
    return true, this.key
end