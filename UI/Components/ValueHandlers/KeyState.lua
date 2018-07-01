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
function this:Setup(
    instance,
    UIObject,
    Changer,
    defaultValue
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
        this.OnEvaluate, -- @TODO
        defaultValue
    )

    instance.state = nil
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