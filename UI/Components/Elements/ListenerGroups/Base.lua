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
    uiObject                    UIObject
    listenerSetup               function(Listener, UIObject, ListenerGroup)
    onNotify                    function(...)
    onActivate                  function()
    onDeactivate                function()
]]
function this:Setup(
    instance,
    uiObject,
    listenerSetup,
    onNotify,
    onActivate,
    onDeactivate
)

    instance.UIObject = uiObject
    instance.OnActivate = onActivate
    instance.OnDeactivate = onDeactivate
    
    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate

    local listeners = instance.Listeners
    for i=1, #listeners do -- must come after value assignment
        listenerSetup(listeners[i], uiObject, onNotify)
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