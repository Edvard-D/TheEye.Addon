local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.Listeners.EvaluatorListener = {}
local this = TheEyeAddon.UI.Components.Elements.Listeners.EvaluatorListener
local inherited = TheEyeAddon.UI.Components.Elements.Listeners.Base

local ListenerRegister = TheEyeAddon.Events.Evaluators.ListenerRegister
local ListenerUnregister = TheEyeAddon.Events.Evaluators.ListenerUnregister


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    eventEvaluatorKey = #EVALUATOR#NAME#
    inputValues = { #EVALUATOR#TEMPLATE#inputValues# }
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    OnNotify                    function(...)
]]
function this:Setup(
    instance,
    UIObject,
    OnNotify
)

    inherited:Setup(
        instance,
        UIObject,
        OnNotify,
        this.Register,
        this.Unregister
    )
end

function this:Register()
    ListenerRegister(self.eventEvaluatorKey, self)
end

function this:Unregister()
    ListenerUnregister(self.eventEvaluatorKey, self)
end