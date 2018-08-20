TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedIntChanger = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedIntChanger
local inherited = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger

local select = select


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    valueHandler                ValueHandler
]]
function this.Setup(
    instance,
    valueHandler
)

    inherited.Setup(
        instance,
        valueHandler,
        this.ChangeValueByState
    )
end

function this:ChangeValueByState(listener, event, state)
    if state == true then
        return listener.value
    else
        return listener.value * -1
    end
end