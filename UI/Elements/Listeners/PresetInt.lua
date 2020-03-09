TheEye.Core.UI.Elements.Listeners.PresetInt = {}
local this = TheEye.Core.UI.Elements.Listeners.PresetInt
local inherited = TheEye.Core.UI.Elements.Listeners.Base


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