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
    modifyListener              { function OnModify(), function OnDemodify() }
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
    self.modifyListener:OnModify(self.UIObject.frame)
end

function this:OnRelease()
    self.modifyListener:OnDemodify(self.UIObject.frame)
end