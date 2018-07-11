local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.IntegerKeyState = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.IntegerKeyState
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyState


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    validKeys = { #INT# = true }
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    onStateChange               function(#BOOL#)
]]
function this.Setup(
    instance,
    uiObject,
    onStateChange
)

    inherited.Setup(
        instance,
        uiObject,
        this.Add,
        0,
        onStateChange
    )
end

function this:Add(value)
    self.value = self.value + value
end