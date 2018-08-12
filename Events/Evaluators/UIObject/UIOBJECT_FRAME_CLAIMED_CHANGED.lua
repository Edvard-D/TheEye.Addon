TheEyeAddon.Events.Evaluators.UIOBJECT_FRAME_CLAIMED_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UIOBJECT_FRAME_CLAIMED_CHANGED
this.name = "UIOBJECT_FRAME_CLAIMED_CHANGED"


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#UIObject Key# #UIOBJECT#KEY# }
}
]]


this.customEvents =
{
    "UIOBJECT_FRAME_CLAIMED",
    "UIOBJECT_FRAME_RELEASED",
}


local function CalculateCurrentValue(uiObject)
    return uiObject.frame ~= nil
end

function this:InputGroupSetup(inputGroup)
    local uiObject = TheEyeAddon.UI.Objects.Instances[inputGroup.inputValues[1]]
    inputGroup.currentValue = CalculateCurrentValue(uiObject)
end

function this:GetKey(event, uiObject)
    return uiObject.key
end

function this:Evaluate(inputGroup, event, uiObject)
    local isClaimed = CalculateCurrentValue(uiObject)

    if inputGroup.currentValue ~= isClaimed then
        inputGroup.currentValue = isClaimed
        return true, this.name, isClaimed
    end
end