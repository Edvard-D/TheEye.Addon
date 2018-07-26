TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifiers.Base = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifiers.Base
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    valueChangeListener         { function #valueChangeFunctionName#(#VALUE#) }
    valueChangeFunctionName     #STRING#
]]
function this.Setup(
    instance,
    uiObject,
    valueChangeListener,
    valueChangeFunctionName
)

    inherited.Setup(
        instance,
        uiObject,
        nil,
        nil,
        nil,
        this.OnValueChange, -- @TODO
        false
    )

    instance.ValueChangeListener = valueChangeListener
    instance.valueChangeFunctionName = valueChangeFunctionName
end