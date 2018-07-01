local TheEyeAddon = TheEyeAddon
local thisName = "Game_Data_Loaded"
local this = TheEyeAddon.Events.Evaluators[thisName]


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