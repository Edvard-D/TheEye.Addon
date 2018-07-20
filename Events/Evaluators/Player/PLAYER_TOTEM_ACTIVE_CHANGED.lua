local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.PLAYER_TOTEM_ACTIVE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.PLAYER_TOTEM_ACTIVE_CHANGED
this.name = "PLAYER_TOTEM_ACTIVE_CHANGED"

local GetTotemInfo = GetTotemInfo


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Totem Name# #STRING#,
    }
}
]]


this.gameEvents = 
{
    "PLAYER_TOTEM_UPDATE",
}


local function CalculateCurrentValue(inputValues)
    for i=1,4 do
        local _, totemName = GetTotemInfo(i)
        if totemName == inputValues[1] then
            return true
        end
    end

    return false
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, totemSlot)
    local _, totemName = GetTotemInfo(totemSlot)
    return totemName
end

function this:Evaluate(inputGroup, event, totemSlot)
    local isActive = GetTotemInfo(totemSlot)

    if inputGroup.currentValue ~= isActive then
        inputGroup.currentValue = isActive
        return true, this.name, isActive
    end
end