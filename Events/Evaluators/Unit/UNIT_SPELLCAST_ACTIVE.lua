local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_ACTIVE = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_ACTIVE

local select = select
local table = table
local UnitCastingInfo = UnitCastingInfo


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #LABEL#Unit# #UNIT#
        #LABEL#Spell ID# #SPELL#ID#
    }
}
]]


this.type = "STATE"
this.gameEvents =
{
    "UNIT_SPELLCAST_CHANNEL_START",
    "UNIT_SPELLCAST_CHANNEL_STOP",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP"
}


function this:CalculateCurrentState(inputValues)
    local expectedSpellID = inputValues[2]
    local currentSpellID = select(9, UnitCastingInfo(inputValues[1]))

    if currentSpellID == expectedSpellID then
        return true
    else
        return false
    end
end

function this:GetKey(event, ...)
    local unit, _, spellID = ...
    return table.concat({ unit, spellID })
end

function this:Evaluate(valueGroup, event)
    if event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START" then -- @TODO maybe refactor to use CombatEvent?
        return true
    else -- UNIT_SPELLCAST_STOP / UNIT_SPELLCAST_CHANNEL_STOP
        return false
    end
end