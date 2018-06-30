local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState


function this:Create(
    ValidKeys, -- table with integer keys
    OnValidKey, -- function
    OnInvalidKey -- function
)
    instance = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base:Create(
        this.ChangeValue,
        0
    )

    instance.ValidKeys = ValidKeys
    instance.OnValidKey = OnValidKey
    instance.OnInvalidKey = OnInvalidKey

    return instance
end