TheEyeAddon.Events.Evaluators.ADDON_LOADED = {}
local this = TheEyeAddon.Events.Evaluators.ADDON_LOADED

local select = select


--[[ #this#TEMPLATE#
{
    inputValues = { #LABEL#Addon Name# #STRING# }
}
]]


this.gameEvents = 
{
    "ADDON_LOADED"
}


function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = false
end

function this:GetKey(event, ...)
    return select(1, ...)
end

function this:Evaluate()
    return true, this.key, true
end