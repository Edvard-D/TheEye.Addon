TheEyeAddon.UI.Elements.ValueHandlers.StaticValue = {}
local this = TheEyeAddon.UI.Elements.ValueHandlers.StaticValue
local inherited = TheEyeAddon.UI.Elements.ValueHandlers.Base


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