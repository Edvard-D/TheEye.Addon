TheEyeAddon.UI.Components.Elements.ValueHandlers.StaticValue = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.StaticValue
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    value = #VALUE#
}
]]


--[[ #SETUP#
    instance
]]
function this.Setup(
    instance
)

    inherited.Setup(
        instance,
        nil,
        nil,
        nil,
        nil,
        instance.value,
        "value"
    )
end