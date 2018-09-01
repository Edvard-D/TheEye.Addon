TheEyeAddon.UI.Components.Child = {}
local this = TheEyeAddon.UI.Components.Child
local inherited = TheEyeAddon.UI.Components.Elements.Base

local VisibleStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller.Setup
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

    -- VisibleStateFunctionCaller
    instance.OnShow = this.OnShow
    instance.OnHide = this.OnHide

    instance.VisibleStateFunctionCaller = {}
    VisibleStateFunctionCallerSetup(
        instance.VisibleStateFunctionCaller,
        instance,
        2
    )
end

function this:OnShow()
    UIObjectInstances[self.parentKey].Group:ChildRegister(self.UIObject)
end

function this:OnHide()
    UIObjectInstances[self.parentKey].Group:ChildDeregister(self.UIObject)
end