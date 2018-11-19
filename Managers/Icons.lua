TheEyeAddon.Managers.Icons = {}
local this = TheEyeAddon.Managers.Icons


local table = table
this.values = {}


function this.Add(icon)
    table.insert(this.values, icon)
end

local function IsIconValidForFilter(icon, filter)
    local properties = icon.properties
    for i = 1, #properties do
        if properties[i].type == filter.type and properties[i].value == filter.value then
            return true
        end
    end
end

local function IsIconValidForFilters(icon, filters)
    local filterTypeStates = {}
    for i = 1, #filters do
        local filter = filters[i]
        if filterTypeStates[filter.type] == nil then
            filterTypeStates[filter.type] = false
        end
        if filterTypeStates[filter.type] ~= true and IsIconValidForFilter(icon, filter) == true then
            filterTypeStates[filter.type] = true
        end
    end

    for k,v in pairs(filterTypeStates) do
        if v == false then
            return false
        end
    end

    return true
end

function this.GetFiltered(filters)
    local filteredIcons = {}
    local values = this.values

    for i = 1, #values do
        if IsIconValidForFilters(values[i], filters) == true then
            table.insert(filteredIcons, values[i])
        end
    end

    return filteredIcons
end

function this.GetPropertiesOfType(icon, propertyType)
    local filteredProperties
    local properties = icon.properties

    for i = 1, #properties do
        local property = properties[i]
        if property.type == propertyType then
            if filteredProperties == nil then
                filteredProperties = property
            elseif type(filteredProperties) ~= "table" then
                filteredProperties = { filteredProperties, property }
            else
                table.insert(filteredProperties, property)
            end
        end
    end

    return filteredProperties
end