TheEyeAddon.UI.Components.EnabledState = {}
local this = TheEyeAddon.UI.Components.EnabledState
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local SendCustomEvent = TheEyeAddon.Managers.Events.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)
    
    inherited.Setup(
        instance,
        this.Enable,
        this.Disable
    )

    instance:Activate()
end

function this:Enable()
    self.state = true
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end

function this:Disable()
    self.state = false
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end