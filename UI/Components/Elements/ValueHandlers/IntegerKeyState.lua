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
    stateChangeListener         function(#BOOL#)
]]
function this.Setup(
    instance,
    uiObject,
    stateChangeListener
)

    inherited.Setup(
        instance,
        uiObject,
        this.Add,
        0,
        stateChangeListener
    )
end

function this:Add(value)
    return self.value + value
end