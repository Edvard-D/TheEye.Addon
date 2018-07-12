local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    valueAction                 function(#VALUE#)
    onValueChange               function(#VALUE#)
    defaultValue                #VALUE#
]]
function this.Setup(
    instance,
    uiObject,
    valueAction,
    onValueChange,
    defaultValue
)

    instance.UIObject = uiObject
    instance.ValueAction = valueAction
    instance.OnValueChange = onValueChange
    instance.defaultValue = defaultValue
    instance.value = defaultValue

    instance.Change = this.Change
    instance.Reset = this.Reset
end

function this:Change(value)
    if self.ValueAction ~= nil then
        value = self:ValueAction(value)
    end
    
    if self.value ~= value then
        self.value = value
        
        if self.OnValueChange ~= nil then
            self:OnValueChange(value)
        end
    end
end

function this:Reset()
    self.value = self.defaultValue

    if self.ValueAction ~= nil then
        self.value = self:ValueAction(self.value)
    end
    
    if self.OnValueChange ~= nil then
        self:OnValueChange(self.value)
    end
end