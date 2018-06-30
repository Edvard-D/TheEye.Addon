local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState

-- DEFINED IN TEMPLATE
--      ValidKeys           table { [0] = true }


-- SETUP
--      instance
--      UIObject            UIObject
--      OnValidKey          function(...)
--      OnInvalidKey        function(...)
function this:Setup(
    instance,
    UIObject,
    OnValidKey,
    OnInvalidKey
)

    TheEyeAddon.UI.Objects.Components.ValueHandlers.Base:Setup(
        instance,
        UIObject,
        this.ChangeValue,
        0
    )

    instance.state = nil
    instance.ValidKeys = ValidKeys
    instance.OnValidKey = OnValidKey
    instance.OnInvalidKey = OnInvalidKey
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