local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_CLASS = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_CLASS

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


this.type = "STATE"
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
    return this:CalculateCurrentState(valueGroup.inputValues)
end