local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger
local inherited = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueChanger

local select = select


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

function this:ChangeValueByState(...)
    local state = select(...)

    if state == true then
        return value
    else
        return self.value * -1
    end
end