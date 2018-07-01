local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState

--[[ TEMPLATE
ValidKeys =
{
    [0] = true    
}
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      OnValidKey                  function()
--      OnInvalidKey                function()
function this:Setup(
    instance,
    UIObject,
    OnValidKey,
    OnInvalidKey
)

    TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState:Setup(
        instance,
        UIObject,
        TheEyeAddon.UI.Objects.Components.ValueHandlers.Base.Add,
        0,
        instance.ValidKeys,
        OnValidKey,
        OnInvalidKey
    )
end