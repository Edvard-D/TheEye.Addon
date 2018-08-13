TheEyeAddon.UI.Components.Elements.Frame = {}
local this = TheEyeAddon.UI.Components.Elements.Frame
this.name = "Frame"

local NotifyBasedFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.NotifyBasedFunctionCaller.Setup
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent
local VisibleStateFunctionCallerSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller.Setup


--[[ #this#TEMPLATE#
{
    #OPTIONAL#DisplayData =
    {
        #OPTIONAL#DimensionTemplate =
        {
            #OPTIONAL#PointSettings =
            {
                #OPTIONAL#point = #POINT#
                #OPTIONAL#relativePoint = #RELATIVEPOINT#
                #OPTIONAL#offsetX = #NUMBER#
                #OPTIONAL#offsetY = #NUMBER#
            }
            #OPTIONAL#width = #NUMBER#
            #OPTIONAL#height = #NUMBER#
        }
    }
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
    factory                     UI.Factories
]]
function this.Setup(
    instance,
    uiObject,
    factory
)

    instance.UIObject = uiObject
    instance.Factory = factory

    uiObject.DisplayData = instance.DisplayData
    uiObject.Frame = instance

    -- VisibleStateFunctionCaller
    instance.OnShow = this.OnShow
    instance.OnHide = this.OnHide

    instance.VisibleStateFunctionCaller = {}
    VisibleStateFunctionCallerSetup(
        instance.VisibleStateFunctionCaller,
        uiObject,
        instance,
        1
    )
end

function this:OnShow()
    self.state = true
    self.instance = self.Factory.Claim(self.UIObject, nil, self.DisplayData)
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, this.name)
end

function this:OnHide()
    self.state = false
    self.instance:Release()
    self.instance = nil
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, this.name)
end