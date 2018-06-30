local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger


-- SETUP
--      instance
--      ValueHandler
function this:Setup(
    instance,
    ValueHandler
)

    TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger:Setup(
        instance,
        ValueHandler,
        OnEvaluate -- @TODO
    )
end