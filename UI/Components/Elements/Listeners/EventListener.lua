local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.Listeners.EventListener = {}
local this = TheEyeAddon.UI.Components.Elements.Listeners.EventListener
local inherited = TheEyeAddon.UI.Components.Elements.Listeners.Base

local ListenerRegister = TheEyeAddon.Events.Coordinator.Register
local ListenerUnregister = TheEyeAddon.Events.Coordinator.Unregister


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    eventName = #EVENT#NAME#
    inputValues = { #EVENT#TEMPLATE#inputValues# }
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
        OnNotify,
        this.Register,
        this.Unregister
    )
end

function this:Register()
    ListenerRegister(self.eventName, self)
end

function this:Unregister()
    ListenerUnregister(self.eventName, self)
end