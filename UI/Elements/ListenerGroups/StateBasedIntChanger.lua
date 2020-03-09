TheEye.Core.UI.Elements.ListenerGroups.StateBasedIntChanger = {}
local this = TheEye.Core.UI.Elements.ListenerGroups.StateBasedIntChanger
local inherited = TheEye.Core.UI.Elements.ListenerGroups.ValueChanger

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