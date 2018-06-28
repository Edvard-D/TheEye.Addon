local TheEyeAddon = TheEyeAddon
TheEyeAddon.Auras = { }

local ipairs = ipairs
local table = table


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