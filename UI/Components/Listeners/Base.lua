local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.Base = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.Base


function this:Setup(
    instance,
    -- this
    evaluatorKey,   -- string: must match the name of an Evaluator
    inputValues,    -- table: structure defined by Evaluators
    OnEvaluate      -- function
)

    instance.evaluatorKey = evaluatorKey
    instance.inputValues = inputValues
    instance.OnEvaluate = OnEvaluate

    -- @TODO register with Evaluator

    return instance 
end