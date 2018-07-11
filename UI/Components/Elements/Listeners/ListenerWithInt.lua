local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.Listeners.ListenerWithInt = {}
local this = TheEyeAddon.UI.Components.Elements.Listeners.ListenerWithInt
local inherited = TheEyeAddon.UI.Components.Elements.Listeners.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    value = #INT#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    OnNotify                    function(#LISTENER#, ...)
]]
function this:Setup(
    instance,
    UIObject,
    OnNotify
)

    inherited:Setup(
        instance,
        UIObject,
        OnNotify
    )
end