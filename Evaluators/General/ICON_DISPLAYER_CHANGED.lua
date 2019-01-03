TheEyeAddon.Evaluators.ICON_DISPLAYER_CHANGED = {}
local this = TheEyeAddon.Evaluators.ICON_DISPLAYER_CHANGED

local DisplayerGet = TheEyeAddon.Managers.Icons.DisplayerGet
local table = table


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Spell ID# #SPELL#ID#
        #LABEL#Displayer ID# #UIOBJECT#ID#
    }
}
]]


this.customEvents =
{
    "ICON_DISPLAYER_CHANGED",
}
this.reevaluateEvents =
{
    ICON_DISPLAYER_CHANGED = true
}


function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = DisplayerGet(inputGroup.inputValues[1]) == inputGroup.inputValues[2]
end

function this:Evaluate(inputGroup, event, iconID, displayerID)
    local isDisplayer = displayerID == inputGroup.inputValues[2]
    
    if inputGroup.currentValue ~= isDisplayer then
        inputGroup.currentValue = isDisplayer
        return true, this.key
    end
end