local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.Base = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.Base

-- DEFINED IN TEMPLATE
--      evaluatorKey        string: must match the name of an Evaluator
--      inputValues         table: structure defined by Evaluators


-- SETUP
--      instance
--      UIObject            UIObject
--      ListenerGroup       ListenerGroup: ListenerGroup this is assigned to
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
    TheEyeAddon.Events.Evaluators:RegisterListener(instance.evaluatoryKey, instance)
end

function this:Deactivate()
    TheEyeAddon.Events.Evaluators:UnregisterListener(evaluatorName, listener)
end