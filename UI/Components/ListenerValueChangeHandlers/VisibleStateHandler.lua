local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueChangeHandlers.VisibleStateHandler = {}
local this = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.VisibleStateHandler
local inherited = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.KeyStateFunctionCaller

local EnabledStateReactorSetup = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.EnabledStateReactor.Setup
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent
local FrameRelease = TheEyeAddon.UI.Pools.Release


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}

#UIOBJECT#DisplayData#TEMPLATE#
{
    factory = #TheEyeAddon.UI.Factories#NAME#
    DimensionTemplate =
    {
        PointSettings =
        {
            point = #POINT#
            relativePoint = #POINT#
            offsetY = #INT#
        }
    }
}
]]


--[[ SETUP
    instance
    UIObject                    UIObject
]]
function this:Setup(
    instance,
    UIObject
)
    
    inherited:Setup(
        instance,
        UIObject,
        this.Show,
        this.Hide
    )
    
    instance.OnEnable = this.OnEnable
    instance.OnDisable = this.OnDisable

    instance.EnabledStateReactor = {}
    EnabledStateReactorSetup(
        instance.EnabledStateReactor,
        UIObject,
        instance.OnEnable,
        instance.OnDisable
    )
end

function this:OnEnable()
    self:Activate()
end

function this:OnDisable()
    self:Deactivate()
end

function this:Show()
    print ("SHOW    " .. self.UIObject.key) -- DEBUG
    self.UIObject.frame = self.DisplayData.factory:Claim(self.UIObject, self.UIObject.DisplayData)
    SendCustomEvent("UIOBJECT_SHOWN", self.UIObject)
end

function this:Hide()
    print ("HIDE    " .. self.UIObject.key) -- DEBUG
    FrameRelease(self.UIObject.frame)
    self.UIObject.frame = nil
    SendCustomEvent("UIOBJECT_HIDDEN", self.UIObject)
end