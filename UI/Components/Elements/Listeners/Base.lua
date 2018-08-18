TheEyeAddon.UI.Components.Elements.Listeners.Base = {}
local this = TheEyeAddon.UI.Components.Elements.Listeners.Base
local inherited = TheEyeAddon.UI.Components.Elements.Base

local Comparisons = TheEyeAddon.Helpers.Comparisons
local ListenerRegister = TheEyeAddon.Events.Helpers.Core.ListenerRegister
local ListenerDeregister = TheEyeAddon.Events.Helpers.Core.ListenerDeregister


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    eventEvaluatorKey = #EVALUATOR#NAME#
    inputValues = { #EVALUATOR#TEMPLATE#inputValues# }
    #OPTIONAL#priority = #INT#
}
]]


--[[ #SETUP#
    instance
    notificationHandler         { OnNotify:function(listener, ...) }
]]
function this.Setup(
    instance,
    notificationHandler
)

    inherited.Setup(
        instance
    )

    instance.NotificationHandler = notificationHandler

    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate
    instance.Notify = this.Notify
    instance.Register = this.Register
    instance.Deregister = this.Deregister

    if instance.inputValues ~= nil then
        local inputValues = instance.inputValues
        for i = 1, #inputValues do
            if inputValues[i] == "#SELF#UIOBJECT#KEY#" then
                inputValues[i] = instance.UIObject.key
                instance.isInternal = true
            end
        end
    end
end

function this:Activate()
    self:Register()
end

function this:Deactivate()
    self:Deregister()
end

function this:Notify(event, ...)
    if self.comparisonValues == nil then
        self.NotificationHandler:OnNotify(self, event, ...)
    else
        local currentValue = ...
        local comparisonState = Comparisons[self.comparisonValues.type](
            currentValue, self.comparisonValues)
        if (self.comparisonState ~= comparisonState and self.comparisonState ~= nil)
            or (self.comparisonState == nil and comparisonState == true)
            then
            self.comparisonState = comparisonState
            self.NotificationHandler:OnNotify(self, event, comparisonState)
        end
    end
end

function this:Register()
    ListenerRegister(self.eventEvaluatorKey, self)
end

function this:Deregister()
    ListenerDeregister(self.eventEvaluatorKey, self)
end