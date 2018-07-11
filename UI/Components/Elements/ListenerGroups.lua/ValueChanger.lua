local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base

local ListenerWithIntSetup = TheEyeAddon.UI.Components.Elements.Listeners.ListenerWithInt.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ValueHandler                ValueHandler
    ValueAction                 function(Listener, ...)
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
        ListenerWithIntSetup,
        this.ChangeValue,
        ValueHandler.Reset,
        ValueHandler.Reset
    )

    instance.ValueHandler = ValueHandler
    instance.ValueAction = ValueAction
end

function this:ChangeValue(listener, ...)
    self.ValueHandler:Change(self:ValueAction(listener, ...))
end