local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger


-- SETUP
--      instance
--      ValueHandler
function this:Setup(
    instance,
    ValueHandler
)

    TheEyeAddon.UI.Objects.Components.ListenerGroups.Base:Setup(
        instance,
        TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger.Setup,
        ValueHandler.Reset,
        ValueHandler.Reset,
        OnEvaluate -- @TODO
    )

    instance.ValueHandler = ValueHandler
end