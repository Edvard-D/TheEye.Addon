TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifier = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifier
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    valueChangeListener         { function #valueChangeFunctionName#(#VALUE#) }
    valueChangeFunctionName     #STRING#
    defaultValue                #VALUE#
]]
function this.Setup(
    instance,
    valueChangeListener,
    valueChangeFunctionName,
    defaultValue
)

    inherited.Setup(
        instance,
        nil,
        nil,
        nil,
        this.OnValueChange,
        defaultValue,
        "value"
    )

    instance.ValueChangeListener = valueChangeListener
    instance.valueChangeFunctionName = valueChangeFunctionName
end

function this:OnValueChange(value)
    self.ValueChangeListener[self.valueChangeFunctionName](self.ValueChangeListener, value)
end