TheEyeAddon.UI.Components.Child = {}
local this = TheEyeAddon.UI.Components.Child
local inherited = TheEyeAddon.UI.Components.Elements.Base

local FrameStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller.Setup
local UIObjectInstances = TheEyeAddon.UI.Objects.Instances


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    parentKey = #UIOBJECT#KEY#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    inherited.Setup(
        instance
    )

    -- FrameStateFunctionCaller
    instance.OnClaim = this.OnClaim
    instance.OnRelease = this.OnRelease

    instance.FrameStateFunctionCaller = {}
    FrameStateFunctionCallerSetup(
        instance.FrameStateFunctionCaller,
        instance,
        2
    )
end

function this:OnClaim()
    UIObjectInstances[self.parentKey].Group:ChildRegister(self.UIObject)
end

function this:OnRelease()
    UIObjectInstances[self.parentKey].Group:ChildDeregister(self.UIObject)
end