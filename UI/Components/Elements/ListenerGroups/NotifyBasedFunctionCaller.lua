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
    uiObject                    UIObject
    calledFunction              function(...)
]]
function this:Setup(
    instance,
    uiObject,
    calledFunction
)

    inherited:Setup(
        instance,
        uiObject,
        ListenerBaseSetup,
        this.OnNotify,
        nil,
        nil
    )

    instance.CalledFunction = calledFunction
end

function this.CallFunction(listener, ...)
    self:CalledFunction(...)
end