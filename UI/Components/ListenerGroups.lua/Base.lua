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
--      OnEvaluate          function(...)
function this:Setup(
    instance,
    ListenerSetup,
    OnSetup,
    OnTeardown,
    OnEvaluate
)

    for i=1, #Listeners do
        ListenerSetup(Listeners[i])
    end

    instance.OnSetup = OnSetup
    instance.OnTeardown = OnTeardown
    instance.OnEvaluate = OnEvaluate
end