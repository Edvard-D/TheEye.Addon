local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.TableBase = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.TableBase
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base

local table = table


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    onTableValuesChange         function()
]]
function this.Setup(
    instance,
    uiObject,
    onTableValuesChange
)

    instance.OnTableChange = this.OnTableChange
    inherited.Setup(
        instance,
        uiObject,
        nil,
        instance.OnTableChange,
        {}
    )

    instance.OnTableValuesChange = onTableValuesChange

    instance.Insert = this.Insert
    instance.Remove = this.Remove
end

function this:OnTableChange()
    self.OnTableValuesChange()
end

function this:Insert(value)
    table.insert(self.value, value)
    self.OnTableValuesChange()
end

function this:Remove(value)
    local wasRemoved = table.removekeyvalue(self.value, value) -- @TODO allow use of table.removevalue too?
    if wasRemoved == true then
        self.OnTableValuesChange()
    end
end