TheEyeAddon.UI.Components.EnabledState = {}
local this = TheEyeAddon.UI.Components.EnabledState
this.name = "EnabledState"
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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
    
    inherited.Setup(
        instance,
        uiObject,
        this.Enable,
        this.Disable
    )

    instance:Activate()
end

function this:Enable()
    --print ("ENABLE    " .. self.UIObject.key) -- DEBUG
    self.state = true
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, this.name)
end

function this:Disable()
    --print ("DISABLE    " .. self.UIObject.key) -- DEBUG
    self.state = false
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, this.name)
end