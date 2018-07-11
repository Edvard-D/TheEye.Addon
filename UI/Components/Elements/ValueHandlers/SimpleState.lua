local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.SimpleState = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.SimpleState
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    onStateChange               function()
]]
function this.Setup(
    instance,
    uiObject,
    onStateChange
)

    inherited.Setup(
        instance,
        uiObject,
        nil,
        onStateChange,
        false
    )
end