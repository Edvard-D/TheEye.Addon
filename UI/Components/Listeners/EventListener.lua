local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.EventListener = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.EventListener
local inherited = TheEyeAddon.UI.Objects.Components.Listeners.Base


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
        this.Register, -- @TODO
        this.Unregister -- @TODO
    )
end