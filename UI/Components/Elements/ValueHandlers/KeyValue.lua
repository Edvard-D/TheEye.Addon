TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyValue = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyValue
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base

local DebugLogEntryAdd = TheEyeAddon.Managers.Debug.LogEntryAdd
local SendCustomEvent = TheEyeAddon.Managers.Events.SendCustomEvent


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

function this:OnDeactivate()
    self:OnValueChange(self.defaultKey)
end

function this:OnValueChange(key)
    local value = self.validKeys[key]

    DebugLogEntryAdd("TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyValue", "OnValueChange", self.UIObject, self.Component, key, value)
    
    if self.value ~= value then
        self.value = value
        SendCustomEvent("UIOBJECT_COMPONENT_VALUE_CHANGED", self.UIObject, self.Component, "value")
    end
end