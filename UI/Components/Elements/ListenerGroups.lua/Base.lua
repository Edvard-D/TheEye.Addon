local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.Base = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base


--[[ #this#TEMPLATE#
{
    Listeners = { #ARRAY#TheEyeAddon.UI.Components.Elements.Listeners#NAME#TEMPLATE# }
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ListenerSetup               function(Listener, UIObject, ListenerGroup)
    OnNotify                    function(...)
    OnActivate                  function()
    OnDeactivate                function()
]]
function this:Setup(
    instance,
    UIObject,
    ListenerSetup,
    OnNotify,
    OnActivate,
    OnDeactivate
)

    instance.UIObject = UIObject
    instance.OnActivate = OnActivate
    instance.OnDeactivate = OnDeactivate
    
    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate

    local listeners = instance.Listeners
    for i=1, #listeners do -- must come after value assignment
        ListenerSetup(listeners[i], UIObject, OnNotify)
    end
end

function this:Activate()
    if self.OnActivate ~= nil then 
        self:OnActivate() -- must be called before activating listeners
    end
    
    local listeners = self.Listeners
    for i=1, #listeners do
        listeners[i]:Activate()
    end
end

function this:Deactivate()
    if self.OnDeactivate ~= nil then
        self:OnDeactivate()
    end

    local listeners = self.Listeners
    for i=1, #listeners do
        listeners[i]:Deactivate()
    end
end