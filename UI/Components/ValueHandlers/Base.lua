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
    Action                      function(#VALUE#)
    Evaluator                   ValueEvaluator
    OnEvaluate                  function()
    valueDefault                #VALUE#
]]
function this:Setup(
    instance,
    UIObject,
    Action,
    Evaluator,
    OnEvaluate,
    defaultValue
)

    instance.UIObject = UIObject
    instance.Action = Action
    instance.Evaluator = Evaluator
    instance.OnEvaluate = OnEvaluate
    instance.defaultValue = defaultValue
    instance.value = defaultValuee
end

function this:Change(value)
    self.value = self.Action(value)
    self.OnEvaluate(self.Evaluator(self.value))
end

function this:Reset()
    self.value = self.defaultValue
end