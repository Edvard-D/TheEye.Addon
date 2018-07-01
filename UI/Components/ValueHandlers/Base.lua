local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ValueAction                 function(#VALUE#)
    Evaluator                   ValueEvaluator
    Notify                  function()
    valueDefault                #VALUE#
]]
function this:Setup(
    instance,
    UIObject,
    ValueAction,
    Evaluator,
    Notify,
    defaultValue
)

    instance.UIObject = UIObject
    instance.ValueAction = ValueAction
    instance.Evaluator = Evaluator
    instance.Notify = Notify
    instance.defaultValue = defaultValue
    instance.value = defaultValuee

    instance.Change = this.Change
    instance.Reset = this.Reset
end

function this:Change(value)
    self.value = self.ValueAction(value)
    self.Notify(self.Evaluator:Evaluate(self.value))
end

function this:Reset()
    self.value = self.defaultValue
end