TheEyeAddon.UI.Elements.ValueHandlers.SortedTable = {}
local this = TheEyeAddon.UI.Elements.ValueHandlers.SortedTable
local inherited = TheEyeAddon.UI.Elements.ValueHandlers.TableBase

local table = table


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    sortActionnName             string
    sortValueComponentName      string
]]
function this.Setup(
    instance,
    sortActionName,
    sortValueComponentName
)

    instance.Sort = this.Sort
    inherited.Setup(
        instance,
        instance.Sort
    )

    if sortActionName ~= nil then
        instance.SortAction = this[sortActionName]
    end
    instance.sortValueComponentName = sortValueComponentName
end

function this:Sort()
    if self.SortAction ~= nil then
        self:SortAction()
    end
end

-- Sort Actions
function this:SortAscending()
    table.sort(self[self.valueKey], function(a,b)
        local aValue = a[self.sortValueComponentName]:SortValueGet()
        local bValue = b[self.sortValueComponentName]:SortValueGet()

        if aValue == nil then
            return false
        end
        
        if bValue == nil then
            return true
        end

        return aValue < bValue end)
end

function this:SortDescending()
    table.sort(self[self.valueKey], function(a,b)
        local aValue = a[self.sortValueComponentName]:SortValueGet()
        local bValue = b[self.sortValueComponentName]:SortValueGet()

        if aValue == nil then
            return false
        end
        
        if bValue == nil then
            return true
        end

        return aValue > bValue end)
end