local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local table = table
local unpack = unpack


-- inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "_", --[[spellID]] "_" }
TheEyeAddon.Events.Evaluators.Unit_Aura_Active =
{
    type = "STATE",
    reevaluateEvents =
    {
        PLAYER_TARGET_CHANGED = true
    },
    gameEvents =
    {
        "PLAYER_TARGET_CHANGED"
    },
    combatLogEvents =
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
}

function TheEyeAddon.Events.Evaluators.Unit_Aura_Active:SetupListeningTo(valueGroup)
    for i,auraName in ipairs(self.combatLogEvents) do
        TheEyeAddon.Events.Evaluators:RegisterValueGroupListeningTo(valueGroup,
        {
            listeningToKey = "Combat_Log",
            evaluator = TheEyeAddon.Events.Evaluators.Unit_Aura_Active,
            inputValues = { auraName, valueGroup.inputValues[1], valueGroup.inputValues[2] }
        })
    end
end

function TheEyeAddon.Events.Evaluators.Unit_Aura_Active:CalculateCurrentState(inputValues)
    local sourceUnitExpected, destUnit, spellIDExpected = unpack(inputValues)

    if TheEyeAddon.Auras:UnitAuraGetBySpellID(sourceUnitExpected, destUnit, spellIDExpected) ~= nil then
        return true
    else
        return false
    end
end

function TheEyeAddon.Events.Evaluators.Unit_Aura_Active:GetKey(event, ...)
    local combatLogData = ...
    return table.concat({ combatLogData["sourceUnit"], combatLogData["destUnit"], combatLogData["spellID"] })
end

function TheEyeAddon.Events.Evaluators.Unit_Aura_Active:Evaluate(valueGroup, event, ...)
    if event == "PLAYER_TARGET_CHANGED" then
        return TheEyeAddon.Events.Evaluators.Unit_Aura_Active:CalculateCurrentState(valueGroup.inputValues)
    else
        local combatLogData = ...
        
        if combatLogData["suffix"] == "AURA_APPLIED" then
            return true
        else -- AURA_BROKEN_SPELL, AURA_BROKEN, AURA_REMOVED
            return false
        end
    end
end