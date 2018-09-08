TheEyeAddon.UI.Components.FrameModifierBase = {}
local this = TheEyeAddon.UI.Components.FrameModifierBase
local inherited = TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local EnabledStateFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller.Setup
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

    -- EnabledStateFunctionCaller
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateFunctionCaller = {}
    EnabledStateFunctionCallerSetup(
        instance.EnabledStateFunctionCaller,
        instance,
        1
    )
end

function this:OnEnable()
    self:Activate()
end

function this:OnDisable()
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