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
    ListenerGroup               ListenerGroup
]]
function this:Setup(
    instance,
    UIObject,
    ListenerGroup
)

    instance.UIObject = UIObject
    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate
    instance.ListenerGroup = ListenerGroup
    instance.OnEvaluate = ListenerGroup.OnEvaluate
end

function this:Activate()
    RegisterListener(instance.evaluatoryKey, instance)
end

function this:Deactivate()
    UnregisterListener(evaluatorName, listener)
end