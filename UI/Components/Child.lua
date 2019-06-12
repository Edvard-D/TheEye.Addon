TheEyeAddon.UI.Components.Child = {}
local this = TheEyeAddon.UI.Components.Child
local inherited = TheEyeAddon.UI.Elements.Base

local FrameStateFunctionCallerSetup = TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller.Setup
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

    instance.Deactivate = this.Deactivate

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

function this:Deactivate()
    self.FrameStateFunctionCaller:Deactivate()
end

function this:OnClaim()
    UIObjectInstances[self.parentKey].Group:ChildRegister(self.UIObject)
end

function this:OnRelease()
    UIObjectInstances[self.parentKey].Group:ChildDeregister(self.UIObject)
end