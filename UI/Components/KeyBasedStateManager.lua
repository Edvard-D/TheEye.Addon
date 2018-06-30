local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.KeyBasedStateManager = {}
local this = TheEyeAddon.UI.Components.KeyBasedStateManager

-- DEFINED IN TEMPLATE
--      ValueHandler            ValueHandler: must be of type KeyState
--      ListenerGroup           ListenerGroup: must be of type StateBasedValueChanger


-- SETUP
--      instance
--      OnValidKey              function(...)
--      OnInvalidKey            function(...)
function this:Setup(
    instance,
    OnValidKey,
    OnInvalidKey
)
    
    TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState:Setup(
        instance.ValueHandler,
        OnValidKey,
        OnInvalidKey
    )

    TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger:Setup(
        instance.ListenerGroup,
        instance.ValueHandler
    )
end