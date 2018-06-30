local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.Base = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.Base

-- DEFINED IN TEMPLATE
--      evaluatorKey        string: must match the name of an Evaluator
--      inputValues         table: structure defined by Evaluators


-- SETUP
--      instance
--      OnEvaluate          function(...)
function this:Setup(
    instance,
    OnEvaluate
)

    instance.evaluatorKey = evaluatorKey
    instance.OnEvaluate = OnEvaluate

    -- @TODO register with Evaluator
end