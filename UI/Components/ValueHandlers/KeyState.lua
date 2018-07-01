local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState
local inherited = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base
local evaluator = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValidKeys = { #VALUE# = true }
    Evaluator = #evaluator#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    Changer                     function(#VALUE#)
    valueDefault                #VALUE#
    OnValidKey                  function()
    OnInvalidKey                function()
]]
function this:Setup(
    instance,
    UIObject,
    Changer,
    defaultValue,
    OnValidKey,
    OnInvalidKey
)

    local evaluatorInstance = evaluator:Setup(
        instance.Evaluator or {},
        UIObject,
        instance.ValidKeys
    )

    inherited:Setup(
        instance,
        UIObject,
        Changer,
        evaluatorInstance,
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