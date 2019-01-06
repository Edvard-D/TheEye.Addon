TheEyeAddon.Managers.Icons = {}
local this = TheEyeAddon.Managers.Icons

local Comparisons = TheEyeAddon.Helpers.Comparisons
local keyValues = {}
local SendCustomEvent = TheEyeAddon.Managers.Events.SendCustomEvent
local table = table
local values = {}


function this.Add(icon)
    local key = this.GetPropertiesOfType(icon, "OBJECT_ID").value

    keyValues[key] = icon
    table.insert(values, icon)
end

function this.DisplayerAdd(iconID, displayerID)
    TheEyeAddon.Managers.Debug.LogEntryAdd("TheEyeAddon.Managers.Icons", "DisplayerChange", nil, nil, iconID, displayerID)
    
    if keyValues[iconID].displayers == nil then
        keyValues[iconID].displayers = {}
    end
    keyValues[iconID].displayers[displayerID] = true
    SendCustomEvent("ICON_DISPLAYER_CHANGED", iconID, displayerID, true)
end

function this.DisplayerRemove(iconID, displayerID)
    keyValues[iconID].displayers[displayerID] = nil
    SendCustomEvent("ICON_DISPLAYER_CHANGED", iconID, displayerID, false)
end

function this.DisplayersGet(iconID)
    return keyValues[iconID].displayers
end

function this.IsIconValidForFilter(icon, filter)
    local properties = icon.properties
    for i = 1, #properties do
        local property = properties[i]
        if property.type == filter.type
            and (property.value == filter.value
                or (filter.comparisonValues ~= nil and Comparisons[filter.comparisonValues.type](property.value, filter.comparisonValues) == true))
            then
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

function this.GetFiltered(filterGroups)
    local filteredIcons = {}

    for i = 1, #values do
        for j = 1, #filterGroups do
            if IsIconValidForFilters(values[i], filterGroups[j]) == true then
                table.insert(filteredIcons, values[i])
            end
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