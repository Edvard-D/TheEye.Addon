local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState

--[[ TEMPLATE
ValidKeys =
{
    [value] = true
}
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      Changer                     function(value)
--      valueDefault                value
--      OnValidKey                  function()
--      OnInvalidKey                function()
function this:Setup(
    instance,
    UIObject,
    Changer,
    defaultValue,
    OnValidKey,
    OnInvalidKey
)

    local evaluator = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue:Setup(
        {},
        UIObject,
        instance.ValidKeys
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