TheEyeAddon.UI.Components.FrameModifier = {}
local this = TheEyeAddon.UI.Components.FrameModifier
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local FrameStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller.Setup
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance                    { #name#STRING#, function Modify(frame), function Demodify(frame) }
    uiObject                    UIObject
]]
function this.Setup(
    instance,
    uiObject
)

    instance.UIObject = uiObject

    -- FrameStateFunctionCaller
    instance.OnClaim = this.OnClaim
    instance.OnRelease = this.OnRelease

    instance.FrameStateFunctionCaller = {}
    FrameStateFunctionCallerSetup(
        instance.FrameStateFunctionCaller,
        uiObject,
        instance,
        1
    )

    -- StateHandler
    inherited.Setup(
        instance,
        uiObject,
        this.OnValidKey,
        this.OnInvalidKey
    )
    
    instance:Activate()
end

local function CallModify(self)
    if self.state == true and self.UIObject.Frame.instance ~= nil then
        self:Modify(self.UIObject.Frame.instance)
    end
end

local function CallDemodify(self)
    self:Demodify(self.UIObject.Frame.instance)
end

function this:OnClaim()
    CallModify(self)
end

function this:OnRelease()
    CallDemodify(self)
end

function this:OnValidKey()
    self.state = true
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self.name)
    CallModify(self)
end

function this:OnInvalidKey()
    self.state = false
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self.name)
    CallDemodify(self)
end