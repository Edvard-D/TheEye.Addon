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
    UIObject                    UIObject
    ValueAction                 function(#VALUE#)
    ValueEvaluator              ValueEvaluator
    OnValueChange               function(#VALUE#)
    defaultValue                #VALUE#
]]
function this:Setup(
    instance,
    UIObject,
    ValueAction,
    ValueEvaluator,
    OnValueChange,
    defaultValue
)

    instance.UIObject = UIObject
    instance.ValueAction = ValueAction
    instance.ValueEvaluator = ValueEvaluator
    instance.OnValueChange = OnValueChange
    instance.defaultValue = defaultValue
    instance.value = defaultValuee

    instance.Change = this.Change
    instance.Reset = this.Reset
end

function this:Change(value)
    if self.ValueAction ~= nil then
        value = self.ValueAction(value)
    end

    if self.ValueEvaluator ~= nil then
        value = self.ValueEvaluator:Evaluate(value)
    end
    
    if self.value ~= value and self.OnValueChange ~= nil then
        self:OnValueChange()
    end
end

function this:Reset()
    self:Change(self.defaultValue)
end