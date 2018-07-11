local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.Base

local ListenerBaseSetup = TheEyeAddon.UI.Components.Elements.Listeners.Base.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    CalledFunction              function(...)
]]
function this:Setup(
    instance,
    UIObject,
    CalledFunction
)

    inherited:Setup(
        instance,
        UIObject,
        ListenerBaseSetup,
        this.OnNotify,
        nil,
        nil
    )

    instance.CalledFunction = CalledFunction
end

function this.CallFunction(listener, ...)
    self:CalledFunction(...)
end