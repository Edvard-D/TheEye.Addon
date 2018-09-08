TheEyeAddon.UI.Elements.Listeners.PresetInt = {}
local this = TheEyeAddon.UI.Elements.Listeners.PresetInt
local inherited = TheEyeAddon.UI.Elements.Listeners.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    value = #INT#
}
]]


--[[ #SETUP#
    instance
    notificationHandler         { OnNotify:function(listener, ...) }
]]
function this.Setup(
    instance,
    notificationHandler
)

    inherited.Setup(
        instance,
        notificationHandler
    )
end