TheEyeAddon.UI.Components.FrameModifier = {}
local this = TheEyeAddon.UI.Components.FrameModifier

local FrameStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller.Setup
local KeyStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ SETUP
    instance                    { #name#STRING#, KeyStateFunctionHandler StateHandler, function Modify(frame), function Demodify(frame) }
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
        instance
    )

    -- StateHandler
    KeyStateFunctionCallerSetup(
        instance.StateHandler,
        uiObject,
        this.OnValidKey,
        this.OnInvalidKey
    )
end

function this:OnClaim()
    if self.StateHandler.state == true then
        self:Modify(self.UIObject.frame)
    end
end

function this:OnRelease()
    self:Demodify(self.UIObject.frame)
end

function this:OnValidKey()
    SendCustomEvent("UIOBJECT_COMPONENT_ENABLED", self.UIObject, self.name)
    if self.UIObject.frame ~= nil then
        self:Modify(self.UIObject.frame)
    end
end

function this:OnInvalidKey()
    SendCustomEvent("UIOBJECT_COMPONENT_DISABLED", self.UIObject, self.name)
    self:Demodify(self.UIObject.frame)
end