local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.Base = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.Base

local ListenerRegister = TheEyeAddon.Events.Evaluators.ListenerRegister
local ListenerUnregister = TheEyeAddon.Events.Evaluators.ListenerUnregister


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    Register                    function()
    Unregister                  function()
    OnNotify                    function(...)
]]
function this:Setup(
    instance,
    UIObject,
    OnNotify,
    Register,
    Unregister
)

    instance.UIObject = UIObject
    instance.OnNotify = OnNotify
    instance.Register = Register
    instance.Unregister = Unregister

    instance.Notify = this.Notify
    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate
end

function this:Notify(...)
    self:OnNotify(...)
end

function this:Activate()
    self:Register()
end

function this:Deactivate()
    self:Unregister()
end