local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.EnabledState = {}
local this = TheEyeAddon.UI.Components.EnabledState
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local SendCustomEvent = TheEyeAddon.Events.Coordinators.OnEvent.SendCustomEvent


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
    SendCustomEvent("UIOBJECT_ENABLED", self.UIObject)
end

function this:Disable()
    --print ("DISABLE    " .. self.UIObject.key) -- DEBUG
    SendCustomEvent("UIOBJECT_DISABLED", self.UIObject)
end