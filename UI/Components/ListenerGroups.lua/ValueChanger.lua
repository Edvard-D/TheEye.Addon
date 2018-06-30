local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger


-- SETUP
--      instance
function this:Setup(
    instance
)

    TheEyeAddon.UI.Objects.Components.ListenerGroups.Base:Setup(
        instance,
        TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger.Setup,
        OnSetup, -- @TODO
        OnTeardown, -- @TODO
        OnEvaluate -- @TODO
    )
end