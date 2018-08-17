TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueSetter = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueSetter
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base

local ListenerBaseSetup = TheEyeAddon.UI.Components.Elements.Listeners.Base.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    valueHandler                ValueHandler
]]
function this.Setup(
    instance,
    valueHandler
)

    inherited.Setup(
        instance,
        ListenerBaseSetup,
        this.SetValue,
        this.OnActivate,
        this.OnDeactivate
    )

    instance.ValueHandler = valueHandler
end

function this:SetValue(listener, ...)
    self.ValueHandler:Change(select(2, ...))
end

function this:OnActivate()
    self.ValueHandler:Activate()
end

function this:OnDeactivate()
    self.ValueHandler:Deactivate()
end