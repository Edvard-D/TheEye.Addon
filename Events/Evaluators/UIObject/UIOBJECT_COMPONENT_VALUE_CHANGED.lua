TheEyeAddon.Events.Evaluators.UIOBJECT_COMPONENT_VALUE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_COMPONENT_VALUE_CHANGED
this.name = "UIOBJECT_COMPONENT_VALUE_CHANGED"

local table = table


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#UIObject Key# #UIOBJECT#KEY#
        #LABEL#Component Name# #COMPONENT#NAME#
        #LABEL#Value Name# #VALUE#NAME#
    }
}
]]


this.customEvents =
{
    "UIOBJECT_COMPONENT_VALUE_CHANGED",
}


local function CalculateCurrentValue(component, valueName)
    if component == nil then return nil end
    
    return component.ValueHandler[valueName]
end

function this:InputGroupSetup(inputGroup)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputGroup.inputValues[1]]
    if uiObject == nil then return nil end

    local component = uiObject[inputGroup.inputValues[2]]
    inputGroup.currentValue = CalculateCurrentValue(component, inputGroup.inputValues[3])
end

function this:GetKey(event, uiObject, component, valueName)
    return table.concat({ uiObject.key, component.key, valueName })
end

function this:Evaluate(inputGroup, event, uiObject, component, valueName)
    local value = CalculateCurrentValue(component, valueName)

    if inputGroup.currentValue ~= value then
        inputGroup.currentValue = value
        return true, this.name, value
    end
end