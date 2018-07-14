local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_INSTANT = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_SPELLCAST_INSTANT
this.name = "UNIT_SPELLCAST_INSTANT"

local table = table


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
    "UNIT_SPELLCAST_START",
    "UNIT_SPELLCAST_STOP",
    "UNIT_SPELLCAST_SUCCEEDED"
}


function this:GetKey(event, ...)
    local unit, _, spellID = ...
    return table.concat({ unit, spellID })
end

function this:Evaluate(inputGroup, event, ...)
    if event == "UNIT_SPELLCAST_SUCCEEDED" then
        if inputGroup.isCasting ~= true then
            return true, this.name, ...
        end
        inputGroup.isCasting = false
    elseif event == "UNIT_SPELLCAST_START" then
        inputGroup.isCasting = true
    else -- UNIT_SPELLCAST_STOP
        inputGroup.isCasting = false
    end

    return false
end