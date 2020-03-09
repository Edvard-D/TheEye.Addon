TheEye.Core.Evaluators.ICON_DISPLAYER_CHANGED = {}
local this = TheEye.Core.Evaluators.ICON_DISPLAYER_CHANGED

local DisplayersGet = TheEye.Core.Managers.Icons.DisplayersGet
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


function this:InputGroupSetup(inputGroup)
    local displayers = DisplayersGet(inputGroup.inputValues[1])
    if displayers ~= nil then
        for k,v in pairs(displayers) do
            if k == inputGroup.inputValues[2] then
                inputGroup.currentValue = v
                return
            end
        end
    end
    inputGroup.currentValue = false
end

function this:GetKey(event, iconID, displayerID)
    return table.concat({ iconID, displayerID })
end

function this:Evaluate(inputGroup, event, iconID, displayerID, isDisplayed)
    TheEye.Core.Managers.Debug.LogEntryAdd("TheEye.Core.Evaluators.ICON_DISPLAYER_CHANGED", "Evaluate", nil, nil, inputGroup.inputValues[1], displayerID, isDisplayed)
    
    if inputGroup.currentValue ~= isDisplayed then
        inputGroup.currentValue = isDisplayed
        return true, this.key
    end
end