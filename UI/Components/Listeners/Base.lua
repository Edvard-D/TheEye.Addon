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
    instance.ListenerGroup = ListenerGroup
    instance.OnEvaluate = ListenerGroup.OnEvaluate

    TheEyeAddon.Events.Evaluators:RegisterListener(instance.evaluatoryKey, instance)
end