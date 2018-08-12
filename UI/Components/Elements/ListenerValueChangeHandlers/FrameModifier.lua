TheEyeAddon.UI.Components.FrameModifier = {}
local this = TheEyeAddon.UI.Components.FrameModifier
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
    modifyListener              { function Modify(), function Demodify() }
]]
function this.Setup(
    instance,
    uiObject,
    modifyListener
)

    inherited.Setup(
        instance,
        uiObject,
        instance
    )

    instance.modifyListener = modifyListener
end

function this:OnClaim()
    self.modifyListener:Modify(self.UIObject.frame)
end

function this:OnRelease()
    self.modifyListener:Demodify(self.UIObject.frame)
end