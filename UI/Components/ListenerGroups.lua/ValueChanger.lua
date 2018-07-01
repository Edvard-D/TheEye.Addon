local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger
local inherited = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

local ListenerSetup = TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    value = #INT#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ValueHandler                ValueHandler
    OnNotify                    function(...)
]]
function this:Setup(
    instance,
    UIObject,
    ValueHandler,
    OnNotify
)

    inherited:Setup(
        instance,
        UIObject,
        ListenerSetup,
        OnNotify,
        ValueHandler.Reset,
        ValueHandler.Reset
    )

    instance.ValueHandler = ValueHandler
end