TheEyeAddon.UI.Components.FrameModifier = {}
local this = TheEyeAddon.UI.Components.FrameModifier
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local FrameStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller.Setup
local SendCustomEvent = TheEyeAddon.Managers.Events.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance                    { function Modify(frame), function Demodify(frame) }
    categoryKey                 #STRING#
    roleKey                     #STRING#
]]
function this.Setup(
    instance,
    categoryKey,
    roleKey
)

    instance.categoryKey = categoryKey
    instance.roleKey = roleKey

    inherited.Setup(
        instance,
        this.OnValidKey,
        this.OnInvalidKey
    )

    -- FrameStateFunctionCaller
    instance.OnClaim = this.OnClaim
    instance.OnRelease = this.OnRelease

    instance.FrameStateFunctionCaller = {}
    FrameStateFunctionCallerSetup(
        instance.FrameStateFunctionCaller,
        instance,
        1
    )
end

function this:OnClaim()
    self:Activate()
end

function this:OnRelease()
    self:Deactivate()
end

function this:OnValidKey()
    self.UIObject.Frame:ModifierAdd(self)
    self.state = true
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end

function this:OnInvalidKey()
    self.UIObject.Frame:ModifierRemove(self)
    self.state = false
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end