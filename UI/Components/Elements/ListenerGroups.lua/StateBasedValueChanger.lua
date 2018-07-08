local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedValueChanger = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedValueChanger
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger

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
    local state = select(...) -- @TODO fix this select since it's not certain what value "state" will be

    if state == true then
        return value
    else
        return self.value * -1
    end
end