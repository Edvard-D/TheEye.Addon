local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.NotifyBasedFunctionCaller = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.NotifyBasedFunctionCaller
local inherited = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

local EventListenerSetup = TheEyeAddon.UI.Objects.Components.Listeners.EventListener.Setup


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