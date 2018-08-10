TheEyeAddon.UI.Components.Child = {}
local this = TheEyeAddon.UI.Components.Child

local VisibleStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller.Setup
local UIObjectInstances = TheEyeAddon.UI.Objects.Instances



--[[ #this#TEMPLATE#
{
    parentKey = #UIOBJECT#KEY#
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
]]
function this.Setup(
    instance,
    uiObject
)

    instance.UIObject = uiObject

    -- VisibleStateFunctionCaller
    instance.OnShow = this.OnShow
    instance.OnHide = this.OnHide

    instance.VisibleStateFunctionCaller = {}
    VisibleStateFunctionCallerSetup(
        instance.VisibleStateFunctionCaller,
        uiObject,
        instance
    )
end

function this:OnShow()
    UIObjectInstances[self.parentKey].Group:ChildRegister(self.UIObject)
end

function this:OnHide()
    UIObjectInstances[self.parentKey].Group:ChildDeregister(self.UIObject)
end