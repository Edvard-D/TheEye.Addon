local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger


-- SETUP
--      instance
--      ValueHandler
function this:Setup(
    instance,
    ValueHandler
)

    TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger:Setup(
        instance,
        ValueHandler,
        this.ChangeValueByState
    )
end

function this:ChangeValueByState(state)
    if state == true then
        self.ValueHandler:ChangeValue(self.value)
    else
        self.ValueHandler:ChangeValue(self.value * -1)
    end
end