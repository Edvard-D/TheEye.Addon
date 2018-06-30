local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger


function this:Setup(
    instance,
    -- base
    evaluatorKey,   -- string: must match the name of an Evaluator
    inputValues,    -- table: structure defined by Evaluators
    OnEvaluate      -- function: should do something with value to ValueGroup
    -- this
    value,          -- integer: value passed to ValueGroup
    ValueGroup     -- ValueGroup
)
    TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger.Base:Setup(
        instance,
        evaluatorKey,
        inputValues,
        OnEvaluate
    )

    instance.value = value
    instance.ValueGroup = ValueGroup

    return instance
end