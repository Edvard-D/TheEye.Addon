-- @REFACTOR Convert event evaluators related to specific component states to use this event evaluator 
TheEyeAddon.Events.Evaluators.UIOBJECT_COMPONENT_STATE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_COMPONENT_STATE_CHANGED
this.name = "UIOBJECT_COMPONENT_STATE_CHANGED"


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#UIObject Key# #UIOBJECT#KEY#
        #LABEL#Component Name# #COMPONENT#NAME#
    }
}
]]


this.customEvents =
{
    "UIOBJECT_COMPONENT_ENABLED",
    "UIOBJECT_COMPONENT_DISABLED"
}


local function CalculateCurrentValue(uiObject, componentName)
    return uiObject[componentName].state or false
end

function this:InputGroupSetup(inputGroup)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputGroup.inputValues[1]]
    inputGroup.currentValue = CalculateCurrentValue(uiObject, inputGroup.inputValues[2])
end

function this:GetKey(event, uiObject, componentName)
    return table.concat({ uiObject.key, componentName})
end

function this:Evaluate(inputGroup, event, uiObject, componentName)
    local state = CalculateCurrentValue(uiObject, componentName)

    if inputGroup.currentValue ~= state then
        inputGroup.currentValue = state
        return true, this.name, state
    end
end