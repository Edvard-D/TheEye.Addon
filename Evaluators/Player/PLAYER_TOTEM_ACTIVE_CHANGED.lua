TheEye.Core.Evaluators.PLAYER_TOTEM_ACTIVE_CHANGED = {}
local this = TheEye.Core.Evaluators.PLAYER_TOTEM_ACTIVE_CHANGED

local InputGroupDurationTimerStart = TheEye.Core.Helpers.Timers.InputGroupDurationTimerStart
local GetTotemInfo = GetTotemInfo
local select = select


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
this.customEvents =
{
    "PLAYER_TOTEM_TIMER_END",
}


local function CalculateCurrentValue(inputValues)
    for i = 1,4 do
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

function this:GetKey(event, ...)
    local totemName

    if event == "PLAYER_TOTEM_UPDATE" then
        local totemSlot = ...
        totemName = select(2, GetTotemInfo(totemSlot))
    else
        totemName = select(2, ...)
    end

    return totemName
end

function this:Evaluate(inputGroup, event, ...)
    local totemSlot
    
    if event == "PLAYER_TOTEM_UPDATE" then
        totemSlot = ...
    else -- PLAYER_TOTEM_TIMER_END
        totemSlot = select(3, ...)
    end

    local isActive, totemName, _, remainingTime = GetTotemInfo(totemSlot)
    if remainingTime > 0 then
        InputGroupDurationTimerStart(inputGroup, remainingTime, "PLAYER_TOTEM_TIMER_END", totemName, totemSlot)
    end

    if inputGroup.currentValue ~= isActive then
        inputGroup.currentValue = isActive
        return true, this.key
    end
end