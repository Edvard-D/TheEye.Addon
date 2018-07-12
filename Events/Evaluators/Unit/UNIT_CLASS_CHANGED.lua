local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_CLASS_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_CLASS_CHANGED
this.name = "UNIT_CLASS_CHANGED"

local select = select
local UnitClass = UnitClass


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Class ID# #CLASS#ID#
    }
}
]]


reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED"
}


function this:CalculateCurrentState(inputValues)
    local classIndex = select(3, UnitClass(inputValues[1]))
    return classIndex == inputValues[2]
end

function this:Evaluate(valueGroup)
    local isClass = this:CalculateCurrentState(valueGroup.inputValues)

    if valueGroup.currentState ~= isClass then
        valueGroup.currentState = isClass
        return true, this.name, isClass
    end
end