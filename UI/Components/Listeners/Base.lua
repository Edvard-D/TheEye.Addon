local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.Base = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.Base

local RegisterListener = TheEyeAddon.Events.Evaluators.RegisterListener
local UnregisterListener = TheEyeAddon.Events.Evaluators.UnregisterListener


--[[ #this#TEMPLATE#
{
    eventEvaluatorKey = #EVALUATOR#name#
    inputValues = { #EVALUATOR#TEMPLATE#inputValues# }
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    Register                    function()
    Unregister                  function()
    ListenerGroup               ListenerGroup
]]
function this:Setup(
    instance,
    UIObject,
    Register,
    Unregister,
    ListenerGroup
)

    instance.UIObject = UIObject
    instance.Register = Register
    instance.Unregister = Unregister
    instance.ListenerGroup = ListenerGroup
    
    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate

    instance.OnEvaluate = ListenerGroup.OnEvaluate
end

function this:Activate()
    self:Register()
end

function this:Deactivate()
    self:Unregister()
end