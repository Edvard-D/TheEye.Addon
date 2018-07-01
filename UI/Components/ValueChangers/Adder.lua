local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueChangers.Adder = {}
local this = TheEyeAddon.UI.Objects.Components.ValueChangers.Adder

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
function this:Setup(
    instance,
    UIObject
)

    TheEyeAddon.UI.Objects.Components.ValueChangers.Base:Setup(
        instance,
        UIObject,
        this.Add, -- @TODO
        0
    )
end