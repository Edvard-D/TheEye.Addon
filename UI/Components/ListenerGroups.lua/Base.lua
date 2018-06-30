local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

-- DEFINED IN TEMPLATE
--      Listeners           table { Listener }


-- SETUP
--      instance
--      UIObject            UIObject
--      ListenerSetup       function(Listener, ListenerGroup)
--      OnEvaluate          function(...)
--      OnActivate          function(...)
--      OnDeactivate        function(...)
function this:Setup(
    instance,
    UIObject,
    ListenerSetup,
    OnEvaluate,
    OnActivate,
    OnDeactivate
)

    instance.UIObject = UIObject

    for i=1, #Listeners do
        ListenerSetup(Listeners[i], instance)
    end

    instance.OnEvaluate = OnEvaluate
    instance.OnActivate = OnActivate
    instance.OnDeactivate = OnDeactivate
end