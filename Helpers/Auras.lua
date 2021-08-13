TheEye.Core.Helpers.Auras = {}
local this = TheEye.Core.Helpers.Auras

local auraFilters = TheEye.Core.Data.auraFilters
local auraMax = 40
local GetPropertiesOfType = TheEye.Core.Managers.Icons.GetPropertiesOfType
local IconsGetFiltered = TheEye.Core.Managers.Icons.GetFiltered
local select = select
local table = table
local UnitAura = UnitAura


function this.UnitAuraGetBySpellID(sourceUnitExpected, destUnit, spellIDExpected)
    local filter = "HELPFUL"

    local icons = IconsGetFiltered(
    {
        {
            {
                type = "OBJECT_ID",
                value = spellIDExpected,
            },
        },
    })

    if #icons > 0 then
        local CATEGORY = GetPropertiesOfType(icons[1], "CATEGORY")
        if CATEGORY.value == "DAMAGE" then
            filter = "HARMFUL"
        end
    end

    for i = 1, auraMax do
        local auraValues = { UnitAura(destUnit, i, filter) }
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

function this.UnitAuraDurationGet(sourceUnit, destUnit, spellIDExpected)
    local auraData = this.UnitAuraGetBySpellID(sourceUnit, destUnit, spellIDExpected)
    
    local remainingTime = 0
    if auraData ~= nil then
        remainingTime = auraData[6] - GetTime()
        if remainingTime < 0 then
            remainingTime = 0
        end
    end
    
    return remainingTime
end