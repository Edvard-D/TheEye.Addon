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
    UIObject                    UIObject
    ListenerGroup               ListenerGroup
]]
function this:Setup(
    instance,
    UIObject,
    ListenerGroup
)
    
    instance.UIObject = UIObject
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