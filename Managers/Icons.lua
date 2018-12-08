TheEyeAddon.Managers.Icons = {}
local this = TheEyeAddon.Managers.Icons


local keyValues = {}
local SendCustomEvent = TheEyeAddon.Managers.Events.SendCustomEvent
local table = table
local values = {}


function this.Add(icon)
    local key = this.GetPropertiesOfType(icon, "OBJECT_ID").value

    keyValues[key] = icon
    table.insert(values, icon)
end

function this.DisplayerChange(iconID, displayerID)
    keyValues[iconID].displayerID = displayerID
    SendCustomEvent("ICON_DISPLAYER_CHANGED", iconID, displayerID)
end

function this.DisplayerGet(iconID)
    return keyValues[iconID].displayerID
end

function this.IsIconValidForFilter(icon, filter)
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
        if filterTypeStates[filter.type] ~= true and this.IsIconValidForFilter(icon, filter) == true then
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

    for i = 1, #values do
        if IsIconValidForFilters(values[i], filters) == true then
            table.insert(filteredIcons, values[i])
        end
    end

    return filteredIcons
end

function this.GetPropertiesOfType(icon, propertyType)
    local filteredProperties = {}
    local properties = icon.properties

    for i = 1, #properties do
        local property = properties[i]
        if property.type == propertyType then
            table.insert(filteredProperties, property)
        end
    end

    local filteredPropertyCount = #filteredProperties
    if filteredPropertyCount == 0 then
        return nil, filteredPropertyCount
    elseif filteredPropertyCount == 1 then
        return filteredProperties[1], filteredPropertyCount
    else
        return filteredProperties, filteredPropertyCount
    end
end