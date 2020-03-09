TheEye.Core.Evaluators.UNIT_AURA_STACK_CHANGED = {}
local this = TheEye.Core.Evaluators.UNIT_AURA_STACK_CHANGED

local InputGroupRegisterListeningTo = TheEye.Core.Managers.Evaluators.InputGroupRegisterListeningTo
local table = table
local UnitAuraGetBySpellID = TheEye.Core.Helpers.Auras.UnitAuraGetBySpellID
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
    "ENVIRONMENTAL_AURA_APPLIED",
    "ENVIRONMENTAL_AURA_APPLIED_DOSE",
    "ENVIRONMENTAL_AURA_BROKEN",
    "ENVIRONMENTAL_AURA_BROKEN_SPELL",
    "ENVIRONMENTAL_AURA_REMOVED",
    "ENVIRONMENTAL_AURA_REMOVED_DOSE",
    "SPELL_AURA_APPLIED",
    "SPELL_AURA_APPLIED_DOSE",
    "SPELL_AURA_BROKEN",
    "SPELL_AURA_BROKEN_SPELL",
    "SPELL_AURA_REMOVED",
    "SPELL_AURA_REMOVED_DOSE",
    "SPELL_BUILDING_AURA_APPLIED",
    "SPELL_BUILDING_AURA_APPLIED_DOSE",
    "SPELL_BUILDING_AURA_BROKEN",
    "SPELL_BUILDING_AURA_BROKEN_SPELL",
    "SPELL_BUILDING_AURA_REMOVED",
    "SPELL_BUILDING_AURA_REMOVED_DOSE",
    "SPELL_PERIODIC_AURA_APPLIED",
    "SPELL_PERIODIC_AURA_APPLIED_DOSE",
    "SPELL_PERIODIC_AURA_BROKEN",
    "SPELL_PERIODIC_AURA_BROKEN_SPELL",
    "SPELL_PERIODIC_AURA_REMOVED",
    "SPELL_PERIODIC_AURA_REMOVED_DOSE",
}


function this:SetupListeningTo(inputGroup)
    for i = 1, #combatLogEvents do
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
    local auraValues = UnitAuraGetBySpellID(sourceUnitExpected, destUnit, spellIDExpected)
    if auraValues ~= nil then
        local stackCount = auraValues[3]
        return stackCount
    else
        return 0
    end
end

function this:InputGroupSetup(inputGroup)
    inputGroup.currentValue = CalculateCurrentValue(inputGroup.inputValues)
end

function this:GetKey(event, inputGroup)
    local eventData = inputGroup.eventData
    return table.concat({ eventData["sourceUnit"], eventData["destUnit"], eventData["spellID"] })
end

function this:Evaluate(inputGroup)
    local stackCount = CalculateCurrentValue(inputGroup.inputValues)

    if inputGroup.currentValue ~= stackCount then
        inputGroup.currentValue = stackCount
        return true, this.key
    end
end