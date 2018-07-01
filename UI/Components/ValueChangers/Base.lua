local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueChangers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueChangers.Base

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      Execute                     function(value)
--      valueDefault                value
function this:Setup(
    instance,
    UIObject,
    Execute,
    valueDefault
)

    instance.UIObject = UIObject
    instance.Execute = Execute
    instance.valueDefault = valueDefault
    instance.value = valueDefault
end