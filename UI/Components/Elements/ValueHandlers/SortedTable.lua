TheEyeAddon.UI.Components.Elements.ValueHandlers.SortedTable = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortedTable
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.TableBase

local table = table


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    sortActionnName             string
    sortValueComponentName      string
]]
function this.Setup(
    instance,
    uiObject,
    sortActionName,
    sortValueComponentName
)

    instance.Sort = this.Sort
    inherited.Setup(
        instance,
        uiObject,
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
    table.sort(self.value, function(a,b)
        return a[self.sortValueComponentName].ValueHandler.value < b[self.sortValueComponentName].ValueHandler.value end)
end

function this:SortDescending()
    table.sort(self.value, function(a,b)
        return a[self.sortValueComponentName].ValueHandler.value > b[self.sortValueComponentName].ValueHandler.value end)
end