local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState


function this:Create(
    ValidKeys, -- table: integer keys
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

function this:ChangeValue(valueChangeAmount)
    if valueChangeAmount ~= nil then
        self.value = self.value + valueChangeAmount
    end

    if self.ValidKeys[self.value] ~= self.state then
        self.state = self.ValidKeys[self.value]

        if self.state == true then
            self:OnValidKey()
        else
            self:OnInvalidKey()
        end
    end
end