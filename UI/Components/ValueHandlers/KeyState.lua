local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.KeyState
local inherited = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base

local ReturnKeyPairValueSetup = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValidKeys = { #VALUE# = true }
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    Action                      function(#VALUE#)
    defaultValue                #VALUE#
    OnStateChange               function(#BOOL#)
]]
function this:Setup(
    instance,
    UIObject,
    Action,
    defaultValue,
    OnStateChange
)

    local evaluatorInstance = ReturnKeyPairValueSetup(
        instance.Evaluator or {},
        UIObject,
        instance.ValidKeys
    )

    inherited:Setup(
        instance,
        UIObject,
        Action,
        Changer,
        evaluatorInstance,
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