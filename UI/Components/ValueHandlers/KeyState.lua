local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      Changer                     function(value)
--      valueDefault                value
--      ValidKeys                   table { [key] = state }
--      OnValidKey                  function()
--      OnInvalidKey                function()
function this:Setup(
    instance,
    UIObject,
    Changer,
    defaultValue,
    ValidKeys,
    OnValidKey,
    OnInvalidKey
)

    local evaluator = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue:Setup(
        {},
        UIObject,
        ValidKeys
    )

    this:Setup(
        instance,
        UIObject,
        Changer,
        evaluator,
        this.OnEvaluate,
        defaultValue
    )

    instance.OnValidKey = OnValidKey
    instance.OnInvalidKey = OnInvalidKey
    instance.state = nil
end

function this:OnEvaluate(state)
    if self.state ~= state then
        self.state = self.ValidKeys[self.value]

        if self.state == true then
            self:OnValidKey()
        else
            self:OnInvalidKey()
        end
    end
end