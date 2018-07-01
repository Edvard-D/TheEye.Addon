local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger
local inherited = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base


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
    OnEvaluate                  function()
]]
function this:Setup(
    instance,
    UIObject,
    ValueHandler,
    OnEvaluate
)

    inherited:Setup(
        instance,
        UIObject,
        TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger.Setup,
        OnEvaluate,
        ValueHandler.Reset,
        ValueHandler.Reset
    )

    instance.ValueHandler = ValueHandler
end