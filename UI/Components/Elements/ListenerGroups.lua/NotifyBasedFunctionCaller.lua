local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base

local EvaluatorListenerSetup = TheEyeAddon.UI.Components.Elements.Listeners.EvaluatorListener.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    OnNotify                    function(...)
]]
function this:Setup(
    instance,
    UIObject,
    OnNotify
)

    inherited:Setup(
        instance,
        UIObject,
        EvaluatorListenerSetup,
        OnNotify,
        nil,
        nil
    )
end