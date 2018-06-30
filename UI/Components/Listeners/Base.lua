local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroup.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroup.Base


function this:Create(
    evaluatorKey,   -- string: must match the name of an Evaluator
    OnEvaluate,     -- function
    inputValues     -- table: structure defined by Evaluators
)
    local instance = {}

    instance.evaluatorKey = evaluatorKey
    instance.OnEvaluate = OnEvaluate
    instance.inputValues = inputValues

    -- @TODO register with Evaluator

    return instance 
end