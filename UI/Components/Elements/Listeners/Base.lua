TheEyeAddon.UI.Components.Elements.Listeners.Base = {}
local this = TheEyeAddon.UI.Components.Elements.Listeners.Base

local ListenerRegister = TheEyeAddon.Events.Helpers.Core.ListenerRegister
local ListenerDeregister = TheEyeAddon.Events.Helpers.Core.ListenerDeregister


--[[ #this#TEMPLATE#
{
    eventEvaluatorKey = #EVALUATOR#NAME#
    inputValues = { #EVALUATOR#TEMPLATE#inputValues# }
    #OPTIONAL#isInternal = #BOOL#
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
    instance.Deregister = this.Deregister

    if instance.inputValues ~= nil then
        local inputValues = instance.inputValues
        for i=1, #inputValues do
            if inputValues[i] == "#SELF#UIOBJECT#KEY#" then
                inputValues[i] = uiObject.key
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

function this:Notify(...)
    self.NotificationHandler:OnNotify(self, ...)
end

function this:Register()
    ListenerRegister(self.eventEvaluatorKey, self)
end

function this:Deregister()
    ListenerDeregister(self.eventEvaluatorKey, self)
end