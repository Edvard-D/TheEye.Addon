local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState
local inherited = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValidKeys = { #INT# = true }
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