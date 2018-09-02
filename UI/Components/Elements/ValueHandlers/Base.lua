TheEyeAddon.UI.Components.Elements.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base
local inherited = TheEyeAddon.UI.Components.Elements.Base

local DebugLogEntryAdd = TheEyeAddon.Managers.Debug.LogEntryAdd


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    onActivate                  function()
    onDeactivate                function()
    valueAction                 function(#VALUE#)
    onValueChange               function(#VALUE#)
    defaultValue                #VALUE#
    valueKey                    #VALUE#
]]
function this.Setup(
    instance,
    onActivate,
    onDeactivate,
    valueAction,
    onValueChange,
    defaultValue,
    valueKey
)

    inherited.Setup(
        instance
    )

    instance.OnActivate = onActivate
    instance.OnDeactivate = onDeactivate
    instance.ValueAction = valueAction
    instance.OnValueChange = onValueChange
    instance.defaultValue = defaultValue
    instance.valueKey = valueKey
    instance[valueKey] = defaultValue

    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate
    instance.Change = this.Change
    instance.Reset = this.Reset
    instance.ValueGet = this.ValueGet
end

function this:Activate()
    if self.OnActivate ~= nil then
        self:OnActivate()
    end
end

function this:Deactivate()
    self[self.valueKey] = self.defaultValue
    if self.OnDeactivate ~= nil then
        self:OnDeactivate()
    end
end

function this:Change(value)
    DebugLogEntryAdd("TheEyeAddon.UI.Components.Elements.ValueHandlers.Base", "Change: BEFORE", self.UIObject, self.Component, value)
    
    if self.ValueAction ~= nil then
        value = self:ValueAction(value)
    end
    
    if self[self.valueKey] ~= value then
        DebugLogEntryAdd("TheEyeAddon.UI.Components.Elements.ValueHandlers.Base", "Change: AFTER", self.UIObject, self.Component, value)
        
        self[self.valueKey] = value
        
        if self.OnValueChange ~= nil then
            self:OnValueChange(value)
        end
    end
end

function this:Reset()
    self:Change(self.defaultValue)
end

function this:ValueGet()
    return self[self.valueKey]
end