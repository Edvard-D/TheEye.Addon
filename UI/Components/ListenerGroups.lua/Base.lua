local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base


--[[ #this#TEMPLATE#
{
    Listeners = { #TheEyeAddon.UI.Objects.Components.Listeners.Base#TEMPLATE# }
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ListenerSetup               function(Listener, UIObject, ListenerGroup)
    OnEvaluate                  function()
    OnActivate                  function()
    OnDeactivate                function()
]]
function this:Setup(
    instance,
    UIObject,
    ListenerSetup,
    OnEvaluate,
    OnActivate,
    OnDeactivate
)

    instance.UIObject = UIObject
    instance.OnEvaluate = OnEvaluate
    instance.OnActivate = OnActivate
    instance.OnDeactivate = OnDeactivate
    
    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate

    for i=1, #Listeners do -- must come after value assignment
        ListenerSetup(Listeners[i], UIObject, instance)
    end
end

function this:Activate()
    self:OnActivate() -- must be called before activating listeners

    for i=1, #Listeners do
        Listeners[i].Activate()
    end
end

function this:Deactivate()
    self:OnDeactivate()

    for i=1, #Listeners do
        Listeners[i].Deactivate()
    end
end