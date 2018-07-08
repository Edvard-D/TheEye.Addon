local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.SortedTable = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.SortedTable
local inherited = TheEyeAddon.UI.Objects.Components.ValueHandlers.TableBase


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    sortActionnName             string
    sortValueComponentName      string
]]
function this:Setup(
    instance,
    UIObject,
    sortActionName,
    sortValueComponentName
)

    instance.Sort = this.Sort
    inherited:Setup(
        instance,
        UIObject,
        instance.Sort
    )

    instance.SortAction = this[sortActionName]
    instance.sortValueComponentName = sortValueComponentName
end

function this:Sort()
    self.SortAction()
end