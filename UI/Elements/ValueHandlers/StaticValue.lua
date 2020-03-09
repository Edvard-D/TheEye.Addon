TheEye.Core.UI.Elements.ValueHandlers.StaticValue = {}
local this = TheEye.Core.UI.Elements.ValueHandlers.StaticValue
local inherited = TheEye.Core.UI.Elements.ValueHandlers.Base


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