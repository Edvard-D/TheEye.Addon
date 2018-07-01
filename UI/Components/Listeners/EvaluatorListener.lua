local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.EvaluatorListener = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.EvaluatorListener
local inherited = TheEyeAddon.UI.Objects.Components.Listeners.Base

local RegisterListener = TheEyeAddon.Events.Evaluators.RegisterListener
local UnregisterListener = TheEyeAddon.Events.Evaluators.UnregisterListener


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
    RegisterListener(self.eventEvaluatorKey, self)
end

function this:Unregister()
    UnregisterListener(self.eventEvaluatorKey, self)
end