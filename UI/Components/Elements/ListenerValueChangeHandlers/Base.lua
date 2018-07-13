local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
    valueHandler                ValueHandler
    listenerGroup               ListenerGroup
]]
function this.Setup(
    instance,
    uiObject,
    listenerGroup
)
    
    instance.UIObject = uiObject
    instance.ValueHandler = valueHandler
    instance.ListenerGroup = listenerGroup

    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate
end

function this:Activate()
    self.ListenerGroup:Activate()
    self.ValueHandler:Activate()
end

function this:Deactivate()
    self.ListenerGroup:Deactivate()
end