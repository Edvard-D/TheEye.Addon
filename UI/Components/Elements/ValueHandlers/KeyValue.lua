TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyValue = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyValue
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base

local DebugLogEntryAdd = TheEyeAddon.Debug.LogEntryAdd
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    validKeys = { #VALUE# = #VALUE# }
}
]]


--[[ #SETUP#
    instance
    valueAction                 function(#VALUE#)
    defaultKey                  #VALUE#
]]
function this.Setup(
    instance,
    valueAction,
    defaultKey
)

    inherited.Setup(
        instance,
        this.OnActivate,
        this.OnDeactivate,
        valueAction,
        this.OnValueChange,
        defaultKey,
        "key"
    )

    instance.defaultKey = defaultKey
    instance.value = instance.validKeys[defaultKey]
    instance.ValueGet = this.ValueGet
end

function this:OnActivate()
    self:OnValueChange(self.defaultKey)
end

function this:OnDeactivate()
    self:OnValueChange(self.defaultKey)
end

function this:OnValueChange(value)
    local value = self.validKeys[value]

    DebugLogEntryAdd("TheEyeAddon.UI.Components.KeyState", "OnValueChange", self.UIObject, self.Component, value)
    
    if self.value ~= value then
        self.value = value
        SendCustomEvent("UIOBJECT_COMPONENT_VALUE_CHANGED", self.UIObject, self.Component, "value")
    end
end