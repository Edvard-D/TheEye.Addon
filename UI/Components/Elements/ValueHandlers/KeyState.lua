local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyState
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base

local ReturnKeyPairValueSetup = TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnKeyPairValue.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueEvaluator = #TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnKeyPairValue#TEMPLATE#
    validKeys = { #VALUE# = true }
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

    instance.ValueEvaluator = instance.ValueEvaluator or {}
    ReturnKeyPairValueSetup(
        instance.ValueEvaluator,
        UIObject,
        instance.validKeys
    )

    inherited:Setup(
        instance,
        UIObject,
        ValueAction,
        instance.ValueEvaluator,
        this.OnValueChange,
        defaultValue
    )

    instance.OnStateChange = OnStateChange
    instance.state = nil
end

function this:OnValueChange(state)
    self.state = self.validKeys[self.value]
    self:OnStateChange(state)
end