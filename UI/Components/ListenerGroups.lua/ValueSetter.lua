local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueSetter = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueSetter
local inherited = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

local ListenerSetup = TheEyeAddon.UI.Objects.Components.Listeners.EvaluatorListener.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ValueHandler                ValueHandler
]]
function this:Setup(
    instance,
    UIObject,
    ValueHandler
)

    inherited:Setup(
        instance,
        UIObject,
        ListenerSetup,
        this.SetValue,
        ValueHandler.Reset,
        ValueHandler.Reset
    )

    instance.ValueHandler = ValueHandler
end

function this:SetValue(...)
    self.ValueHandler:Change(select(1, ...))
end