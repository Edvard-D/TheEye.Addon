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
    objectWithFunction
    functionName                #STRING#
]]
function this.Setup(
    instance,
    objectWithFunction,
    functionName
)

    inherited.Setup(
        instance,
        ListenerBaseSetup,
        this.OnNotify,
        nil,
        nil
    )

    instance.ObjectWithFunction = objectWithFunction
    instance.functionName = functionName
end

function this:OnNotify(listener, ...)
    self.ObjectWithFunction[self.functionName](self.ObjectWithFunction, ...)
end