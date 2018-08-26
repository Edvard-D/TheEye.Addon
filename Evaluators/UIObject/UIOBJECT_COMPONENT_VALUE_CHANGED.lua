TheEyeAddon.Evaluators.UIOBJECT_COMPONENT_VALUE_CHANGED = {}
local this = TheEyeAddon.Evaluators.UIOBJECT_COMPONENT_VALUE_CHANGED

local table = table


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#UIObject Key# #UIOBJECT#KEY#
        #LABEL#Component Key# #COMPONENT#KEY#
        #LABEL#Value Key# #VALUE#KEY#
    }
}
]]


this.customEvents =
{
    "UIOBJECT_COMPONENT_VALUE_CHANGED",
}


local function CalculateCurrentValue(component, valueKey)
    if component == nil then return nil end
    
    return component.ValueHandler[valueKey]
end

function this:InputGroupSetup(inputGroup)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputGroup.inputValues[1]]
    if uiObject == nil then return nil end

    local component = uiObject[inputGroup.inputValues[2]]
    inputGroup.currentValue = CalculateCurrentValue(component, inputGroup.inputValues[3])
end

function this:GetKey(event, uiObject, component, valueKey)
    return table.concat({ uiObject.key, component.key, valueKey })
end

function this:Evaluate(inputGroup, event, uiObject, component, valueKey)
    local value = CalculateCurrentValue(component, valueKey)

    if inputGroup.currentValue ~= value then
        inputGroup.currentValue = value
        return true, this.key
    end
end