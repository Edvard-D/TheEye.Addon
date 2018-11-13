TheEyeAddon.Managers.Actions = {}
local this = TheEyeAddon.Managers.Actions


local table = table
this.values = {}


function this.Add(action)
    table.insert(this.values, action)
end

local function IsActionValidForFilter(action, filter)
    local properties = action.properties
    for i = 1, #properties do
        if properties[i].type == filter.type and properties[i].value == filter.value then
            return true
        end
    end
end

local function IsActionValidForFilters(action, filters)
    local filterTypeStates = {}
    for i = 1, #filters do
        local filter = filters[i]
        if filterTypeStates[filter.type] == nil then
            filterTypeStates[filter.type] = false
        end
        if filterTypeStates[filter.type] ~= true and IsActionValidForFilter(action, filter) == true then
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

function this.FilteredGet(filters)
    local filteredActions = {}
    local values = this.values

    for i = 1, #values do
        if IsActionValidForFilters(values[i], filters) == true then
            table.insert(filteredActions, values[i])
        end
    end

    return filteredActions
end