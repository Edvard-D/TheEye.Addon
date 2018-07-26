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
function this.Setup(
    instance,
    uiObject,
    valueHandler,
    valueAction
)

    inherited.Setup(
        instance,
        uiObject,
        PresetIntSetup,
        this.ChangeValue,
        this.OnActivate,
        this.OnDeactivate
    )

    instance.ValueHandler = valueHandler
    instance.ValueAction = valueAction
end

function this:ChangeValue(listener, ...)
    self.ValueHandler:Change(self:ValueAction(listener, ...))
end

function this:OnActivate()
    self.ValueHandler:Reset()
end

function this:OnDeactivate()
    self.ValueHandler:Reset()
end