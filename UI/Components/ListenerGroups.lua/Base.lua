local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

-- DEFINED IN TEMPLATE
--      Listeners           table { Listener }


-- SETUP
--      instance
--      UIObject            UIObject
--      ListenerSetup       function(Listener, ListenerGroup)
--      OnSetup             function(...)
--      OnTeardown          function(...)
--      OnEvaluate          function(...)
function this:Setup(
    instance,
    UIObject,
    ListenerSetup,
    OnSetup,
    OnTeardown,
    OnEvaluate
)

    instance.UIObject = UIObject

    for i=1, #Listeners do
        ListenerSetup(Listeners[i], instance)
    end

    instance.OnSetup = OnSetup
    instance.OnTeardown = OnTeardown
    instance.OnEvaluate = OnEvaluate
end