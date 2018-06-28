local TheEyeAddon = TheEyeAddon
TheEyeAddon.Auras = { }

local ipairs = ipairs
local select = select
local table = table
local UnitAura = UnitAura


local function AuraFiltersGet(subTableKey, filtersKey, sourceUnit)
    local filters = {}

    if sourceUnit == "player" then
        table.insert(filters, "PLAYER ")
    end

    local retrievedFilters = TheEyeAddon.Auras.Filters[subTableKey][filtersKey]
    if retrievedFilters ~= nil then
        for i,v in ipairs(retrievedFilters) do
            table.insert(filters, v)
        end
    end
end


function TheEyeAddon.Auras:UnitAuraGetBySpellID(sourceUnitExpected, destUnit, spellIDExpected)
    for i=1,40 do -- 40 is the maximum number of auras that can be on a unit
        local auraValues = { UnitAura(destUnit, i, table.concat(AuraFiltersGet("SpellID", spellIDExpected, sourceUnitExpected))) }
        local spellID = select(10, auraValues)
        
        if spellID ~= nil then
            local sourceUnit = select(7, auraValues)
            if spellID == spellIDExpected and sourceUnit == sourceUnitExpected then
                return auraValues
            end
        else
            return nil
        end
    end
end