local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueChangeHandlers.EnabledStateHandler = {}
local this = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.EnabledStateHandler
local inherited = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.KeyStateFunctionManager


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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
        this.Enable,
        this.Disable
    )
end

function this:Enable()
    print ("ENABLE    " .. self.UIObject.key) -- DEBUG
    self.UIObject.Enable()
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_ENABLED", self.UIObject)
end

function this:Disable()
    print ("DISABLE    " .. self.UIObject.key) -- DEBUG
    self.UIObject.Disable()
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_DISABLED", self.UIObject)
end