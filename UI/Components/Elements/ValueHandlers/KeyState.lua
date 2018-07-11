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
    uiObject                    UIObject
    valueAction                 function(#VALUE#)
    defaultValue                #VALUE#
    onStateChange               function(#BOOL#)
]]
function this:Setup(
    instance,
    uiObject,
    valueAction,
    defaultValue,
    onStateChange
)

    instance.ValueEvaluator = instance.ValueEvaluator or {}
    ReturnKeyPairValueSetup(
        instance.ValueEvaluator,
        uiObject,
        instance.validKeys
    )

    inherited:Setup(
        instance,
        uiObject,
        valueAction,
        instance.ValueEvaluator,
        this.OnValueChange,
        defaultValue
    )

    instance.OnStateChange = onStateChange
    instance.state = nil
end

function this:OnValueChange(state)
    self.state = self.validKeys[self.value]
    self:OnStateChange(state)
end