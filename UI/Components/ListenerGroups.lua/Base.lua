local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

-- DEFINED IN TEMPLATE
--      Listeners           table { Listener }


-- SETUP
--      instance
--      UIObject            UIObject
--      ListenerSetup       function(Listener, ListenerGroup)
--      OnActivate          function(...)
--      OnDeactivate        function(...)
--      OnEvaluate          function(...)
function this:Setup(
    instance,
    UIObject,
    ListenerSetup,
    OnActivate,
    OnDeactivate,
    OnEvaluate
)

    instance.UIObject = UIObject

    for i=1, #Listeners do
        ListenerSetup(Listeners[i], instance)
    end

    instance.OnActivate = OnActivate
    instance.OnDeactivate = OnDeactivate
    instance.OnEvaluate = OnEvaluate
end