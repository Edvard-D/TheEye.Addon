TheEye.Core.Managers.Icons = {}
local this = TheEye.Core.Managers.Icons

local Comparisons = TheEye.Core.Helpers.Comparisons
local GetSpecialization = GetSpecialization
local GetSpecializationInfo = GetSpecializationInfo
local keyValues = {}
local playerSpec
local SendCustomEvent = TheEye.Core.Managers.Events.SendCustomEvent
local select = select
local sharedValues = {}
local table = table
local UnitClass = UnitClass
local values = {}


function this.Initialize()
    this.gameEvents =
    {
        "PLAYER_ENTERING_WORLD",
        "PLAYER_SPECIALIZATION_CHANGED",
    }
    TheEye.Core.Managers.Events.Register(this)
end

local function UnnecessaryIconsRemove()
    local classID = select(3, UnitClass("player"))
    local necessarySpecs = TheEye.Core.Data.Specializations[classID]

    for specID,v in pairs(keyValues) do
        if table.haskey(necessarySpecs, specID) == false then
            keyValues[specID] = nil
            value[specID] = nil
        end
    end
end

function this:OnEvent(eventName, ...)
    playerSpec = GetSpecializationInfo(GetSpecialization())

    if eventName == "PLAYER_ENTERING_WORLD" then
        UnnecessaryIconsRemove()
    end
end

function this.Add(specID, iconData)
    local key = this.GetPropertiesOfType(iconData, "OBJECT_ID").value

    if specID == "SHARED" then
        for specID,specSpells in pairs(keyValues) do
            if keyValues[specID][key] == nil then
                keyValues[specID][key] = iconData
                table.insert(values[specID], iconData)
            end
        end
    else
        if keyValues[specID] == nil then
            keyValues[specID] = {}
        end
        keyValues[specID][key] = iconData
        
        if values[specID] == nil then
            values[specID] = {}
        end
        table.insert(values[specID], iconData)
    end
end

function this.DisplayerAdd(iconID, displayerID)
    TheEye.Core.Managers.Debug.LogEntryAdd("TheEye.Core.Managers.Icons", "DisplayerChange", nil, nil, iconID, displayerID)
    
    if keyValues[playerSpec][iconID].displayers == nil then
        keyValues[playerSpec][iconID].displayers = {}
    end
    keyValues[playerSpec][iconID].displayers[displayerID] = true
    SendCustomEvent("ICON_DISPLAYER_CHANGED", iconID, displayerID, true)
end

function this.DisplayerRemove(iconID, displayerID)
    keyValues[playerSpec][iconID].displayers[displayerID] = nil
    SendCustomEvent("ICON_DISPLAYER_CHANGED", iconID, displayerID, false)
end

function this.DisplayersGet(iconID)
    return keyValues[playerSpec][iconID].displayers
end

function this.IsIconValidForFilter(iconData, filter)
    local properties = iconData.properties
    for i = 1, #properties do
        local property = properties[i]

        if property.type == filter.type
            and ((filter.value == nil and filter.comparisonValues == nil)
                or (filter.value == property.value and (filter.subvalue == nil or filter.subvalue == property.subvalue))
                or (filter.comparisonValues ~= nil and Comparisons[filter.comparisonValues.type](property.value, filter.comparisonValues) == true))
            then
            return true
        end
    end
end

local function IsIconValidForFilters(iconData, filters)
    local filterTypeStates = {}
    for i = 1, #filters do
        local filter = filters[i]
        if filterTypeStates[filter.type] == nil then
            filterTypeStates[filter.type] = false
        end
        if filterTypeStates[filter.type] == false and this.IsIconValidForFilter(iconData, filter) == true then
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
    local icons = values[playerSpec]

    if icons ~= nil then
        for i = 1, #icons do
            for j = 1, #filterGroups do
                if IsIconValidForFilters(icons[i], filterGroups[j]) == true then
                    table.insert(filteredIcons, icons[i])
                end
            end
        end
    end

    return filteredIcons
end

function this.GetPropertiesOfType(iconData, propertyType, value)
    local filteredProperties = {}
    local properties = iconData.properties

    for i = 1, #properties do
        local property = properties[i]
        if property.type == propertyType
            and (value == nil or property.value == value)
            then
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