TheEyeAddon.Events.Evaluators.UIOBJECT_COMPONENT_STATE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_COMPONENT_STATE_CHANGED

local table = table
local type = type


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#UIObject Key# #UIOBJECT#KEY#
        #LABEL#Component Key# #COMPONENT#KEY#
    }
}
]]


this.customEvents =
{
    "UIOBJECT_COMPONENT_STATE_CHANGED",
}


local function CalculateCurrentValue(component)
    if component == nil then return nil end

    return component.state
end

function this:InputGroupSetup(inputGroup)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputGroup.inputValues[1]]
    if uiObject == nil then return end

    local component = uiObject[inputGroup.inputValues[2]]
    inputGroup.currentValue = CalculateCurrentValue(uiObject, component)
end

function this:GetKey(event, uiObject, ...)
    local componentKey
    local value = ...
    if type(value) == "string" then
        componentKey = value
    else
        local component = value
        componentKey = component.key
    end

    return table.concat({ uiObject.key, componentKey })
end

function this:Evaluate(inputGroup, event, uiObject, component)
    local state = CalculateCurrentValue(component)
    
    if inputGroup.currentValue ~= state then
        inputGroup.currentValue = state
        return true, this.key, state
    end
end