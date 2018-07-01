local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      Evaluator                   ValueEvaluator
--      Changer                     function(value)
--      valueDefault                value
function this:Setup(
    instance,
    UIObject,
    Evaluator,
    Changer,
    defaultValue
)

    instance.UIObject = UIObject

    instance.Evaluator = Evaluator
    instance.Changer = Changer
    instance.defaultValue = defaultValue
    instance.value = defaultValuee
end

function this:Change(value)
    self.Changer(value)
end

-- Changers
function this:Reset()
    self.value = self.defaultValue
end

function this:_Add(value)
    self.value = self.value + value
end