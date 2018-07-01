local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      Changer                     function(value)
--      Evaluator                   ValueEvaluator
--      OnEvaluate                  function(...)
--      valueDefault                value
function this:Setup(
    instance,
    UIObject,
    Changer,
    Evaluator,
    OnEvaluate,
    defaultValue
)

    instance.UIObject = UIObject
    instance.Changer = Changer
    instance.Evaluator = Evaluator
    instance.OnEvaluate = OnEvaluate
    instance.defaultValue = defaultValue
    instance.value = defaultValuee
end

function this:Change(value)
    self.Changer(value)
end

function this:Reset()
    self.value = self.defaultValue
end

-- Changers
function this:_Add(value)
    self.value = self.value + value
end