TheEye.Core.UI.Elements.ListenerGroups.ValueChanger = {}
local this = TheEye.Core.UI.Elements.ListenerGroups.ValueChanger
local inherited = TheEye.Core.UI.Elements.ListenerGroups.Base

local PresetIntSetup = TheEye.Core.UI.Elements.Listeners.PresetInt.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    valueHandler                ValueHandler
    valueAction                 function(Listener, ...)
]]
function this.Setup(
    instance,
    valueHandler,
    valueAction
)

    inherited.Setup(
        instance,
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
    self.ValueHandler:Activate()
end

function this:OnDeactivate()
    self.ValueHandler:Deactivate()
end