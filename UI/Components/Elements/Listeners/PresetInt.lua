local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.Listeners.PresetInt = {}
local this = TheEyeAddon.UI.Components.Elements.Listeners.PresetInt
local inherited = TheEyeAddon.UI.Components.Elements.Listeners.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    value = #INT#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    onNotify                    function(listener, ...)
]]
function this.Setup(
    instance,
    uiObject,
    onNotify
)

    inherited.Setup(
        instance,
        uiObject,
        onNotify
    )
end