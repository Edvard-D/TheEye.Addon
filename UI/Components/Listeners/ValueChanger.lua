local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger

-- DEFINED IN TEMPLATE
--      value               integer


-- SETUP
--      instance
--      ListenerGroup       ListenerGroup: ListenerGroup this is assigned to
function this:Setup(
    instance,
    ListenerGroup
)

    TheEyeAddon.UI.Objects.Components.Listeners.Base:Setup(
        instance,
        ListenerGroup
    )
end