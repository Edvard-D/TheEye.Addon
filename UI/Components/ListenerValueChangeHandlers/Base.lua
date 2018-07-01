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
end