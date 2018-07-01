local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueChangers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueChangers.Base

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      ValueChangeOperation        function(value)
--      valueDefault                value
function this:Setup(
    instance,
    UIObject,
    ValueChangeOperation,
    valueDefault
)

    instance.UIObject = UIObject
    instance.ValueChangeOperation = ValueChangeOperation
    instance.valueDefault = valueDefault
    instance.value = valueDefault
end