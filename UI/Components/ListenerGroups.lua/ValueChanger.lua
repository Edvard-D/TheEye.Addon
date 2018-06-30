local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger


-- SETUP
--      instance
--      UIObject            UIObject
--      ValueHandler        ValueHandler
--      OnEvaluate          function(...)
function this:Setup(
    instance,
    UIObject,
    ValueHandler,
    OnEvaluate
)

    TheEyeAddon.UI.Objects.Components.ListenerGroups.Base:Setup(
        instance,
        UIObject,
        TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger.Setup,
        OnEvaluate,
        ValueHandler.Reset,
        ValueHandler.Reset
    )

    instance.ValueHandler = ValueHandler
end