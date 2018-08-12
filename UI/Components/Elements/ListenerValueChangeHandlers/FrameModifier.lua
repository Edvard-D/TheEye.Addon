TheEyeAddon.UI.Components.FrameModifier = {}
local this = TheEyeAddon.UI.Components.FrameModifier

local FrameStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ SETUP
    instance                    { function Modify(frame), function Demodify(frame) }
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
end

function this:OnClaim()
    self:Modify(self.UIObject.frame)
end

function this:OnRelease()
    self:Demodify(self.UIObject.frame)
end