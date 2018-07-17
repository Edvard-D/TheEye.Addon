-- @TODO maybe refactor to use CombatEvent?

local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_ACTIVE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_ACTIVE_CHANGED
this.name = "UNIT_SPELLCAST_ACTIVE_CHANGED"

local select = select
local StartEventTimer = TheEyeAddon.Timers.StartEventTimer
local table = table
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spell ID# #SPELL#ID#
    }
}
]]


this.gameEvents =
{
    "UNIT_SPELLCAST_CHANNEL_START",
    "UNIT_SPELLCAST_CHANNEL_STOP",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP"
}
this.customEvents =
{
    "SPELLCAST_END_DELAY"
}


local function CalculateCurrentValue(inputValues)
    local expectedSpellID = inputValues[2]
    local unit = inputValues[1]
    local currentSpellID = select(9, UnitCastingInfo(unit)) or select(8, UnitChannelInfo(unit))

    return currentSpellID == expectedSpellID
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, ...)
    local unit
    local spellID

    if event == "SPELLCAST_END_DELAY" then
        local inputValues = select(2, ...)
        unit = inputValues[1]
        spellID = inputValues[2]
    else
        unit, _, spellID = ...
    end

    return table.concat({ unit, spellID })
end

function this:Evaluate(inputGroup, event)
    if event == "UNIT_SPELLCAST_CHANNEL_STOP" or event == "UNIT_SPELLCAST_STOP" then
        StartEventTimer(0.01, "SPELLCAST_END_DELAY", inputGroup.inputValues)
    else
        local isActive = event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" -- else UNIT_SPELLCAST_STOP, UNIT_SPELLCAST_CHANNEL_STOP
        if inputGroup.currentValue ~= isActive then
            inputGroup.currentValue = isActive
            return true, this.name, isActive
        end
    end
end