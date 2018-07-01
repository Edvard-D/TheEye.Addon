local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.EventListener = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.EventListener
local inherited = TheEyeAddon.UI.Objects.Components.Listeners.Base

local RegisterListener = TheEyeAddon.Events.Coordinator.RegisterListener


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
        this.Unregister -- @TODO
    )
end

function this:Register()
    RegisterListener(self.eventName, self)
end