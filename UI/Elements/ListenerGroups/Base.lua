TheEyeAddon.UI.Elements.ListenerGroups.Base = {}
local this = TheEyeAddon.UI.Elements.ListenerGroups.Base
local inherited = TheEyeAddon.UI.Elements.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    Listeners = { #ARRAY#TheEyeAddon.UI.Elements.Listeners#NAME#TEMPLATE# }
}
]]


--[[ #SETUP#
    instance
    listenerSetup               function(listener, uiObject, listenerGroup)
    onNotify                    function(listener, ...)
    onActivate                  function()
    onDeactivate                function()
]]
function this.Setup(
    instance,
    listenerSetup,
    onNotify,
    onActivate,
    onDeactivate
)

    inherited.Setup(
        instance
    )

    instance.OnNotify = onNotify
    instance.OnActivate = onActivate
    instance.OnDeactivate = onDeactivate
    
    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate

    local listeners = instance.Listeners
    for i = 1, #listeners do -- must come after value assignment
        listenerSetup(listeners[i],
            instance
        )
    end
end

function this:Activate()
    if self.OnActivate ~= nil then 
        self:OnActivate() -- must be called before activating listeners
    end
    
    local listeners = self.Listeners
    for i = 1, #listeners do
        listeners[i]:Activate()
    end
end

function this:Deactivate()
    if self.OnDeactivate ~= nil then
        self:OnDeactivate()
    end

    local listeners = self.Listeners
    for i = 1, #listeners do
        listeners[i]:Deactivate()
    end
end