local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base

local PresetIntSetup = TheEyeAddon.UI.Components.Elements.Listeners.PresetInt.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    valueHandler                ValueHandler
    valueAction                 function(Listener, ...)
]]
function this:Setup(
    instance,
    uiObject,
    valueHandler,
    valueAction
)

    inherited:Setup(
        instance,
        uiObject,
        PresetIntSetup,
        this.ChangeValue,
        valueHandler.Reset,
        valueHandler.Reset
    )

    instance.ValueHandler = valueHandler
    instance.ValueAction = valueAction
end

function this:ChangeValue(listener, ...)
    self.ValueHandler:Change(self:ValueAction(listener, ...))
end