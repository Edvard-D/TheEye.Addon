local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger
local inherited = TheEyeAddon.UI.Objects.Components.ListenerGroups.Base

local ValueChangerSetup = TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger.Setup


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
        ValueChangerSetup,
        OnEvaluate,
        ValueHandler.Reset,
        ValueHandler.Reset
    )

    instance.ValueHandler = ValueHandler
end