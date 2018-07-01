local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState
local inherited = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState

local Add = TheEyeAddon.UI.Objects.Components.ValueActions.Add


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
        Add,
        0,
        OnStateChange
    )
end