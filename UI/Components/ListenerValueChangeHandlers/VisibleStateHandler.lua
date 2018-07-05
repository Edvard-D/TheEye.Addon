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
    -- @TODO add DisplayData Template
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
        this.Hide -- @TODO
    )
    
    instance.OnEnable = this.OnEnable -- @TODO
    instance.OnDisable = this.OnDisable -- @TODO

    instance.EnabledStateReactor = {}
    EnabledStateReactorSetup(
        instance.EnabledStateReactor,
        UIObject,
        instance.OnEnable,
        instance.OnDisable
    )
end

function this:Show()
    print ("SHOW    " .. self.UIObject.key) -- DEBUG
    self.UIObject.frame = self.DisplayData.factory:Claim(self.UIObject, self.UIObject.DisplayData)
    SendCustomEvent("UIOBJECT_SHOWN", self.UIObject)
end