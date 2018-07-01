local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueHandlers.Base = {}
local this = TheEyeAddon.UI.Components.ListenerValueHandlers.Base


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