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
    stateChangeListener         table { OnStateChange = function(state) }
]]
function this.Setup(
    instance,
    uiObject,
    valueAction,
    defaultValue,
    stateChangeListener
)

    instance.ValueEvaluator = instance.ValueEvaluator or {}
    ReturnKeyPairValueSetup(
        instance.ValueEvaluator,
        uiObject,
        instance.validKeys
    )

    inherited.Setup(
        instance,
        uiObject,
        valueAction,
        instance.ValueEvaluator,
        this.OnValueChange,
        defaultValue
    )

    instance.StateChangeListener = stateChangeListener
    instance.state = nil
end

function this:OnValueChange(state)
    self.state = self.validKeys[self.value]
    self.StateChangeListener:OnStateChange(state)
end