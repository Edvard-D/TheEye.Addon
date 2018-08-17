TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_INSTANT = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_INSTANT
this.name = "UNIT_SPELLCAST_INSTANT"

local GetTime = GetTime
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


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true,
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED",
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP",
    "UNIT_SPELLCAST_SUCCEEDED"
}


function this:GetKey(event, ...)
    local unit, _, spellID = ...
    return table.concat({ unit, spellID })
end

function this:Evaluate(inputGroup, event, ...)
    if event == "PLAYER_TARGET_CHANGED" then
        inputGroup.isCasting = select(9, UnitCastingInfo(inputGroup.inputValues[1])) == inputGroup.inputValues[2]
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        if inputGroup.isCasting ~= true then
            local castTimestamp = GetTime()
            return true, this.name, inputGroup.inputValues[2], castTimestamp, ...
        end
        inputGroup.isCasting = false
    elseif event == "UNIT_SPELLCAST_START" then
        inputGroup.isCasting = true
    else -- UNIT_SPELLCAST_STOP
        inputGroup.isCasting = false
    end

    return false
end