TheEyeAddon.Events.Evaluators.UIOBJECT_COMPONENT_VALUE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_COMPONENT_VALUE_CHANGED
this.name = "UIOBJECT_COMPONENT_VALUE_CHANGED"


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


local function CalculateCurrentValue(uiObject, componentName, valueName)
    local valueHandler = (uiObject ~= nil and uiObject[componentName] ~= nil and uiObject[componentName].ValueHandler) or nil
    
    if valueHandler == nil then
        return nil
    else
        return valueHandler[valueName]
    end
end

function this:InputGroupSetup(inputGroup)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputGroup.inputValues[1]]
    inputGroup.currentValue = CalculateCurrentValue(uiObject, inputGroup.inputValues[2], inputGroup.inputValues[3])
end

function this:GetKey(event, uiObject, componentName, valueName)
    return table.concat({ uiObject.key, componentName, valueName })
end

function this:Evaluate(inputGroup, event, uiObject, componentName, valueName)
    local value = CalculateCurrentValue(uiObject, componentName, valueName)

    if inputGroup.currentValue ~= value then
        inputGroup.currentValue = value
        return true, this.name, value
    end
end