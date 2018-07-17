local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Evaluators.UNIT_AURA_ACTIVE_CHANGED = {}
local this = TheEyeAddon.Events.Evaluators.UNIT_AURA_ACTIVE_CHANGED
this.name = "UNIT_AURA_ACTIVE_CHANGED"

local InputGroupRegisterListeningTo = TheEyeAddon.Events.Evaluators.InputGroupRegisterListeningTo
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


this.reevaluateEvents =
{
    PLAYER_TARGET_CHANGED = true
}
this.gameEvents =
{
    "PLAYER_TARGET_CHANGED"
}
local combatLogEvents =
{
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


function this:SetupListeningTo(inputGroup)
    for i=1, #combatLogEvents do
        InputGroupRegisterListeningTo(inputGroup,
        {
            listeningToKey = "COMBAT_LOG",
            evaluator = this,
            inputValues = { combatLogEvents[i], inputGroup.inputValues[1], inputGroup.inputValues[2] }
        })
    end
end

local function CalculateCurrentValue(inputValues)
    local sourceUnitExpected, destUnit, spellIDExpected = unpack(inputValues)

    return UnitAuraGetBySpellID(sourceUnitExpected, destUnit, spellIDExpected) ~= nil
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, combatLogData)
    return table.concat({ combatLogData["sourceUnit"], combatLogData["destUnit"], combatLogData["spellID"] })
end

function this:Evaluate(inputGroup, event, combatLogData)
    local isActive

    if event == "PLAYER_TARGET_CHANGED" then
        isActive = CalculateCurrentValue(inputGroup.inputValues)
    else
        isActive = combatLogData["suffix"] == "AURA_APPLIED" -- else AURA_BROKEN_SPELL, AURA_BROKEN, AURA_REMOVED
    end

    if inputGroup.currentValue ~= isActive then
        inputGroup.currentValue = isActive
        return true, this.name, isActive
    end
end