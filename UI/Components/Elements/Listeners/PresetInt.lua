local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.Listeners.PresetInt = {}
local this = TheEyeAddon.UI.Components.Elements.Listeners.PresetInt
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
    OnNotify                    function(listener, ...)
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