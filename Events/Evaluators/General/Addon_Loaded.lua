local TheEyeAddon = TheEyeAddon
local thisName = "Addon_Loaded"
local this = TheEyeAddon.Events.Evaluators[thisName]

local select = select


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Addon Name# #STRING# }
}
]]


this.type = "STATE"
this.gameEvents = 
{
    "ADDON_LOADED"
}


function this:CalculateCurrentState()
    return false
end

function this:GetKey(event, ...)
    return select(1, ...)
end

function this:Evaluate()
    return true
end