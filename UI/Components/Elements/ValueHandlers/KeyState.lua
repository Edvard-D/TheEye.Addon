local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyState
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base

local ReturnKeyPairValueSetup = TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnKeyPairValue.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueEvaluator = #TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnKeyPairValue#TEMPLATE#
    ValidKeys = { #VALUE# = true }
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ValueAction                 function(#VALUE#)
    defaultValue                #VALUE#
    OnStateChange               function(#BOOL#)
]]
function this:Setup(
    instance,
    UIObject,
    ValueAction,
    defaultValue,
    OnStateChange
)

    local ValueEvaluator = ReturnKeyPairValueSetup(
        instance.Evaluator or {},
        UIObject,
        instance.ValidKeys
    )

    inherited:Setup(
        instance,
        UIObject,
        ValueAction,
        ValueEvaluator,
        this.OnValueChange,
        defaultValue
    )

    instance.OnStateChange = OnStateChange
    instance.state = nil
end

function this:OnValueChange(state)
    self.state = self.ValidKeys[self.value]
    self:OnStateChange(state)
end