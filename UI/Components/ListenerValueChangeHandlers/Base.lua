local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueChangeHandlers.Base = {}
local this = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.Base


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ SETUP
    instance
    UIObject                    UIObject
    ValueHandler                ValueHandler
    ListenerGroup               ListenerGroup
]]
function this:Setup(
    instance,
    UIObject,
    ValueHandler,
    ListenerGroup
)
    
    instance.UIObject = UIObject
    instance.ValueHandler = ValueHandler
    instance.ListenerGroup = ListenerGroup

    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate
end

function this:Activate()
    self.ListenerGroup:Activate()
end

function this:Deactivate()
    self.ListenerGroup:Deactivate()
end