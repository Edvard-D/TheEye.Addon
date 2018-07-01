local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      ValueEvaluator              function(value)
--      ValueChanger                function(value)
--      valueDefault                value
function this:Setup(
    instance,
    UIObject,
    ValueEvaluator,
    ValueChanger,
    defaultValue
)

    instance.UIObject = UIObject

    instance.ValueEvaluator = ValueEvaluator
    instance.ValueChanger = ValueChanger
    instance.defaultValue = defaultValue
    instance.value = defaultValuee
end

function this:Change(value)
    self.ValueChanger(value)
end

-- Value Changers
function this:Reset()
    self.value = self.defaultValue
end

function this:_Add(value)
    self.value = self.value + value
end