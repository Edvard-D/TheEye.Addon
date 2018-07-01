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
    OnValidKey                  function()
    OnInvalidKey                function()
]]
function this:Setup(
    instance,
    UIObject,
    OnValidKey,
    OnInvalidKey
)

    inherited:Setup(
        instance,
        UIObject,
        TheEyeAddon.UI.Objects.Components.ValueHandlers.Base.Add,
        0,
        OnValidKey,
        OnInvalidKey
    )
end