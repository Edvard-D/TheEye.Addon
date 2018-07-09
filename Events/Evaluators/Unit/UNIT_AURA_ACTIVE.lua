local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_AURA_ACTIVE = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_AURA_ACTIVE

local ValueGroupRegisterListeningTo = TheEyeAddon.Events.Evaluators.ValueGroupRegisterListeningTo
local table = table
local UnitAuraGetBySpellID = TheEyeAddon.Auras.UnitAuraGetBySpellID
local unpack = unpack


--[[ #this#TEMPLATE#
{
    inputValues =
    {
        #OPTIONAL# #LABEL#Source Unit# #UNIT#
        #LABEL#Destination Unit# #UNIT#
        #LABEL#Spell ID# #SPELL#ID#
    }
}
]]


this.type = "STATE"
reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED"
}
local combatLogEvents =
{
    "RANGE_AURA_APPLIED",
    "RANGE_AURA_BROKEN",
    "RANGE_AURA_BROKEN_SPELL",
    "RANGE_AURA_REMOVED",
    "SPELL_AURA_APPLIED",
    "SPELL_AURA_BROKEN",
    "SPELL_AURA_BROKEN_SPELL",
    "SPELL_AURA_REMOVED",
    "SPELL_BUILDING_AURA_APPLIED",
    "SPELL_BUILDING_AURA_BROKEN",
    "SPELL_BUILDING_AURA_BROKEN_SPELL",
    "SPELL_BUILDING_AURA_REMOVED",
    "SPELL_PERIODIC_AURA_APPLIED",
    "SPELL_PERIODIC_AURA_BROKEN",
    "SPELL_PERIODIC_AURA_BROKEN_SPELL",
    "SPELL_PERIODIC_AURA_REMOVED",
}


function this:SetupListeningTo(valueGroup)
    for i=1, #combatLogEvents do
        ValueGroupRegisterListeningTo(valueGroup,
        {
            listeningToKey = "COMBAT_LOG",
            evaluator = this,
            inputValues = { combatLogEvents[i], valueGroup.inputValues[1], valueGroup.inputValues[2] }
        })
    end
end

function this:CalculateCurrentState(inputValues)
    local sourceUnitExpected, destUnit, spellIDExpected = unpack(inputValues)

    if UnitAuraGetBySpellID(sourceUnitExpected, destUnit, spellIDExpected) ~= nil then
        return true
    else
        return false
    end
end

function this:GetKey(event, ...)
    local combatLogData = ...
    return table.concat({ combatLogData["sourceUnit"], combatLogData["destUnit"], combatLogData["spellID"] })
end

function this:Evaluate(valueGroup, event, ...)
    if event == "PLAYER_TARGET_CHANGED" then
        return this:CalculateCurrentState(valueGroup.inputValues)
    else
        local combatLogData = ...
        
        if combatLogData["suffix"] == "AURA_APPLIED" then
            return true
        else -- AURA_BROKEN_SPELL, AURA_BROKEN, AURA_REMOVED
            return false
        end
    end
end