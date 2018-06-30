local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.Base = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.Base

-- DEFINED IN TEMPLATE
--      evaluatorKey        string: must match the name of an Evaluator
--      inputValues         table: structure defined by Evaluators


-- SETUP
--      instance
--      ListenerGroup       ListenerGroup: ListenerGroup this is assigned to
function this:Setup(
    instance,
    ListenerGroup
)

    instance.ListenerGroup = ListenerGroup
    instance.OnEvaluate = ListenerGroup.OnEvaluate

    -- @TODO register with Evaluator
end