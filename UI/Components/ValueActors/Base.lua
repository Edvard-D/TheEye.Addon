local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueActors.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueActors.Base

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      Execute                     function(value)
function this:Setup(
    instance,
    UIObject,
    Execute
)

    instance.UIObject = UIObject
    instance.Execute = Execute
end