local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger
local inherited = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

local ListenerSetup = TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger.Setup -- @TODO this listener doesn't exist


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