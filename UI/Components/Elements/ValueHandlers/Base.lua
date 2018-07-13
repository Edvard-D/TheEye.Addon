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
    onActivate                  function()
    onDeactivate                  function()
    valueAction                 function(#VALUE#)
    onValueChange               function(#VALUE#)
    defaultValue                #VALUE#
]]
function this.Setup(
    instance,
    uiObject,
    onActivate,
    onDeactivate,
    valueAction,
    onValueChange,
    defaultValue
)

    instance.UIObject = uiObject
    instance.OnActivate = onActivate
    instance.OnDeactivate = onDeactivate
    instance.ValueAction = valueAction
    instance.OnValueChange = onValueChange
    instance.defaultValue = defaultValue
    instance.value = defaultValue

    instance.Activate = this.Activate
    instance.Deactivate = this.Deactivate
    instance.Change = this.Change
    instance.Reset = this.Reset
end

function this:Activate()
    if self.OnActivate ~= nil then
        self:OnActivate()
    end
end

function this:Deactivate()
    self.value = self.defaultValue
    if self.OnDeactivate ~= nil then
        self:OnDeactivate()
    end
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
    self:Change(self.defaultValue)
end