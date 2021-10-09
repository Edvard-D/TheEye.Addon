TheEye.Core.UI.Components.FrameModifierBase = {}
local this = TheEye.Core.UI.Components.FrameModifierBase
local inherited = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

if this.dependencies == nil then
    this.dependencies = {}
end
table.insert(this.dependencies, "Frame")

local EnabledStateFunctionCallerSetup = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller.Setup
local SendCustomEvent = TheEye.Core.Managers.Events.SendCustomEvent


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