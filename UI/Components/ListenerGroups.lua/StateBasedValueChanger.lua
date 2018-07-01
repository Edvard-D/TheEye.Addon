local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger
local inherited = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ValueHandler                ValueHandler
]]
function this:Setup(
    instance,
    UIObject,
    ValueHandler
)

    inherited:Setup(
        instance,
        UIObject,
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