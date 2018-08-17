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
        nil,
        nil,
        instance.OnTableChange,
        {},
        "table"
    )

    instance.OnTableValuesChange = onTableValuesChange

    instance.Insert = this.Insert
    instance.Remove = this.Remove
end

function this:OnTableChange()
    self:OnTableValuesChange()
end

function this:Insert(element)
    table.insert(self["table"], element)
    self:OnTableValuesChange()
end

function this:Remove(element)
    local wasRemoved = table.removevalue(self["table"], element)
    if wasRemoved == true then
        self:OnTableValuesChange()
    end
end