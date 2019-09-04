TheEyeAddon.Helpers.Auras = {}
local this = TheEyeAddon.Helpers.Auras

local auraFilters = TheEyeAddon.Values.auraFilters
local select = select
local table = table
local UnitAura = UnitAura


function this.UnitAuraGetBySpellID(sourceUnitExpected, destUnit, spellIDExpected)
    for i = 1, 40 do -- 40 is the maximum number of auras that can be on a unit
        local auraValues = { UnitAura(destUnit, i) }
        local spellID = auraValues[10]
        
        if spellID ~= nil then
            local sourceUnit = auraValues[7]
            if spellID == spellIDExpected
                and (sourceUnitExpected == "_" or sourceUnit == sourceUnitExpected)
                then
                
                return auraValues
            end
        else
            return nil
        end
    end
end