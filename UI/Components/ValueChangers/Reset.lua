local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueChangers.Reset = {}
local this = TheEyeAddon.UI.Objects.Components.ValueChangers.Reset

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
        this.Execute,
        0
    )
end

function this:Execute(value)
    self.value = self.valueDefault
end