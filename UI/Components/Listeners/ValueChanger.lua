local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger

-- DEFINED IN TEMPLATE
--      value               integer


-- SETUP
--      instance
--      OnEvaluate          function(...): should change ValueGroup
--      ValueGroup          ValueGroup: ValueGroup that should be changed
function this:Setup(
    instance,
    OnEvaluate,
    ValueGroup
)

    TheEyeAddon.UI.Objects.Components.Listeners.Base:Setup(
        instance,
        evaluatorKey,
        inputValues,
        OnEvaluate
    )

    instance.ValueGroup = ValueGroup
end