TheEyeAddon.UI.Components.EnabledState = {}
local this = TheEyeAddon.UI.Components.EnabledState
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller

local DebugLogEntryAdd = TheEyeAddon.Debug.LogEntryAdd
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


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
    DebugLogEntryAdd("TheEyeAddon.UI.Components.EnabledState", "Enable",
        self.UIObject, self.Component)
    self.state = true
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end

function this:Disable()
    DebugLogEntryAdd("TheEyeAddon.UI.Components.EnabledState", "Disable",
        self.UIObject, self.Component)
    self.state = false
    SendCustomEvent("UIOBJECT_COMPONENT_STATE_CHANGED", self.UIObject, self)
end