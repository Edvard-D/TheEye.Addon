local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.TableBase = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.TableBase
local inherited = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    OnTableValuesChange         function()
]]
function this:Setup(
    instance,
    UIObject,
    OnTableValuesChange
)

    instance.OnTableChange = this.OnTableChange
    inherited:Setup(
        instance,
        UIObject,
        nil,
        nil,
        instance.OnTableChange,
        {}
    )

    instance.OnTableValuesChange = OnTableValuesChange

    instance.Insert = this.Insert
    instance.Remove = this.Remove -- @TODO
end

function this:OnTableChange()
    self.OnTableValuesChange()
end

function this:Insert(value)
    table.insert(self.value, value)
    self.OnTableValuesChange()
end