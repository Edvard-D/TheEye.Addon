local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

-- DEFINED IN TEMPLATE
--      Listeners           table { Listener }


-- SETUP
--      instance
--      ListenerSetup       function(Listener)
--      OnSetup             function(...)
--      OnTeardown          function(...)
function this:Setup(
    instance,
    ListenerSetup,
    OnSetup,
    OnTeardown
)

    for i=1, #Listeners do
        ListenerSetup(Listeners[i])
    end

    instance.OnSetup = OnSetup
    instance.OnTeardown = OnTeardown
end