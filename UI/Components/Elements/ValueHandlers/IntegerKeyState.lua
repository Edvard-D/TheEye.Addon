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
    UIObject                    UIObject
    OnStateChange               function(#BOOL#)
]]
function this:Setup(
    instance,
    UIObject,
    OnStateChange
)

    inherited:Setup(
        instance,
        UIObject,
        this.Add,
        0,
        OnStateChange
    )
end

function this:Add(value)
    self.value = self.value + value
end