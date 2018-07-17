local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.GAMEDATA_LOADED = {}
local this = TheEyeAddon.Events.Evaluators.GAMEDATA_LOADED
this.name = "GAMEDATA_LOADED"


--[[ #this#TEMPLATE#
{
    inputValues = nil
}
]]


this.gameEvents =
{
    "PLAYER_ENTERING_WORLD"
}


function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = false
end

function this:GetKey(event, ...)
    return "default"
end

function this:Evaluate()
    return true, this.name, true
end