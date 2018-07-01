local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueActors.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueActors.Base

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      OnValueChanged              function(value)
function this:Setup(
    instance,
    UIObject,
    OnValueChange
)

    instance.UIObject = UIObject
    instance.OnValueChange = OnValueChange
end