local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base

local EventListenerSetup = TheEyeAddon.UI.Components.Elements.Listeners.EventListener.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    OnNotify                    function(...)
]]
function this:Setup(
    instance,
    UIObject,
    OnNotify
)

    inherited:Setup(
        instance,
        UIObject,
        EventListenerSetup,
        OnNotify,
        nil,
        nil
    )
end