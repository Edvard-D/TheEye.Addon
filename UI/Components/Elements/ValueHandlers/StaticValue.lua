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
    uiObject                    UIObject
]]
function this.Setup(
    instance,
    uiObject
)

    inherited.Setup(
        instance,
        uiObject,
        nil,
        nil,
        nil,
        nil,
        instance.value,
        "value"
    )
end