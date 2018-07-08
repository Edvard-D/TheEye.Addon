local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueSetter = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueSetter
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base

local ListenerSetup = TheEyeAddon.UI.Components.Elements.Listeners.EvaluatorListener.Setup


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