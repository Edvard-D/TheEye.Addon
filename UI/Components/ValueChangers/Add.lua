local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueChangers.Add = {}
local this = TheEyeAddon.UI.Objects.Components.ValueChangers.Add

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
    self.value = self.value + value
end