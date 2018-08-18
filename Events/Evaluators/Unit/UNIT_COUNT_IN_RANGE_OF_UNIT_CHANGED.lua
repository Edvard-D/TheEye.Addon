TheEyeAddon.Events.Evaluators.UNIT_COUNT_IN_RANGE_OF_UNIT_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_COUNT_IN_RANGE_OF_UNIT_CHANGED
this.name = "UNIT_COUNT_IN_RANGE_OF_UNIT_CHANGED"


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Hostility# #HOSTILITY#
        #LABEL#Range# #INT#
    }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED"
}