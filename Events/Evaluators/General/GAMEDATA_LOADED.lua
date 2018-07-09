local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.GAMEDATA_LOADED = {}
local this = TheEyeAddon.Events.Evaluators.GAMEDATA_LOADED


--[[ #this#TEMPLATE#
{
    inputValues = nil
}
]]


this.type = "STATE"
this.gameEvents =
{
    "PLAYER_ENTERING_WORLD"
}


function this:CalculateCurrentState()
    return false
end

function this:GetKey(event, ...)
    return "default"
end

function this:Evaluate()
    return true
end