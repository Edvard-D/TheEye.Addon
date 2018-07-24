local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Child = {}
local this = TheEyeAddon.UI.Components.Child

local EnabledStateReactorSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateReactor.Setup
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

    -- EnabledStateReactor
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable -- @TODO

    instance.EnabledStateReactor = {}
    EnabledStateReactorSetup(
        instance.EnabledStateReactor,
        uiObject,
        instance
    )
end

function this:OnEnable()
    UIObjectInstances[self.parentKey].Parent:ChildRegister(self)
end