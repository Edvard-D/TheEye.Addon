TheEye.Core.Evaluators.UNIT_SPELLCAST_TYPE_ACTIVE_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_SPELLCAST_TYPE_ACTIVE_CHANGED

local select = select
local StartEventTimer = TheEye.Core.Helpers.Timers.StartEventTimer
local table = table
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spell Type# #SPELL#TYPE#
    }
}
]]


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true,
    UNIT_SPELLCAST_CHANNEL_START = true,
    UNIT_SPELLCAST_CHANNEL_STOP = true,
    UNIT_SPELLCAST_START = true,
    UNIT_SPELLCAST_STOP = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_SPELLCAST_CHANNEL_START",
    "UNIT_SPELLCAST_CHANNEL_STOP",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP"
}


local function CalculateCurrentValue(inputValues)
    local unit = inputValues[1]
    local castType = inputValues[2]

    if castType == "CAST" then
        return select(9, UnitCastingInfo(unit)) ~= nil
    else -- CHANNEL
        return select(8, UnitChannelInfo(unit)) ~= nil
    end
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:Evaluate(inputGroup, event)
    local isActive = CalculateCurrentValue(inputGroup.inputValues)
    if inputGroup.currentValue ~= isActive then
        inputGroup.currentValue = isActive
        return true, this.key
    end
end