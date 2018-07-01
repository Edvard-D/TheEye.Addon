local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState
local inherited = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base

local ReturnKeyPairValueSetup = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    Evaluator = #TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue#TEMPLATE#
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

    local Evaluator = ReturnKeyPairValueSetup(
        instance.Evaluator or {},
        UIObject,
        instance.ValidKeys
    )

    inherited:Setup(
        instance,
        UIObject,
        ValueAction,
        Evaluator,
        this.OnEvaluate,
        defaultValue
    )

    instance.OnStateChange = OnStateChange
    instance.state = nil
end

function this:OnEvaluate(state)
    if self.state ~= state then
        self.state = self.ValidKeys[self.value]
        self:OnStateChange(state)
    end
end