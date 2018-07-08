local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base

local ListenerSetup = TheEyeAddon.UI.Components.Elements.Listeners.EvaluatorListener.Setup


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
    ValueAction                 function(...)
]]
function this:Setup(
    instance,
    UIObject,
    ValueHandler,
    ValueAction
)

    inherited:Setup(
        instance,
        UIObject,
        ListenerSetup,
        this.ChangeValue,
        ValueHandler.Reset,
        ValueHandler.Reset
    )

    instance.ValueHandler = ValueHandler
    instance.ValueAction = ValueAction
end

function this:ChangeValue(...)
    self.ValueHandler:Change(self:ValueAction(...))
end