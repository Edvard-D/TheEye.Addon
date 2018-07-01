local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.EvaluatorListener = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.EvaluatorListener
local inherited = TheEyeAddon.UI.Objects.Components.Listeners.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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

    inherited:Setup(
        instance,
        UIObject,
        ListenerGroup,
        this.Register,
        this.Unregister
    )
end

function this:Register()
    RegisterListener(instance.evaluatoryKey, instance)
end

function this:Unregister()
    UnregisterListener(evaluatorName, listener)
end