local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.Listeners.Base = {}
local this = TheEyeAddon.UI.Components.Elements.Listeners.Base

local ListenerRegister = TheEyeAddon.Events.Evaluators.ListenerRegister
local ListenerUnregister = TheEyeAddon.Events.Evaluators.ListenerUnregister


--[[ #this#TEMPLATE#
{
    eventEvaluatorKey = #EVALUATOR#NAME#
    inputValues = { #EVALUATOR#TEMPLATE#inputValues# }
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    notificationHandler         { OnNotify:function(listener, ...) }
]]
function this.Setup(
    instance,
    uiObject,
    notificationHandler
)

    instance.UIObject = uiObject
    instance.NotificationHandler = notificationHandler

    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate
    instance.Notify = this.Notify
    instance.Register = this.Register
    instance.Unregister = this.Unregister
end

function this:Activate()
    self:Register()
end

function this:Deactivate()
    self:Unregister()
end

function this:Notify(...)
    self.NotificationHandler:OnNotify(self, ...)
end

function this:Register()
    ListenerRegister(self.eventEvaluatorKey, self)
end

function this:Unregister()
    ListenerUnregister(self.eventEvaluatorKey, self)
end