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
    "PLAYER_ENTERING_WORLD",
    "PLAYER_LEAVING_WORLD",
}


function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = false
end

function this:GetKey(event)
    return "default"
end

function this:Evaluate(inputGroup, event)
    inputGroup.currentValue = event == "PLAYER_ENTERING_WORLD" -- else PLAYER_LEAVING_WORLD
    return true, this.name, inputGroup.currentValue
end