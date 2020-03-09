TheEye.Core.UI.Elements.ListenerValueChangeHandlers.IntegerKeyValueEventSender = {}
local this = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.IntegerKeyValueEventSender
local inherited = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.Base

local IntegerKeyValueSetup = TheEye.Core.UI.Elements.ValueHandlers.IntegerKeyValue.Setup
local StateBasedIntChangerSetup = TheEye.Core.UI.Elements.ListenerGroups.StateBasedIntChanger.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = #TheEye.Core.UI.Elements.ValueHandlers.IntegerKeyValue#TEMPLATE#
    ListenerGroup = #TheEye.Core.UI.Elements.ListenerGroups.StateBasedIntChanger#TEMPLATE#
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)
    
    IntegerKeyValueSetup(
        instance.ValueHandler
    )

    if instance.ListenerGroup ~= nil then
        StateBasedIntChangerSetup(
            instance.ListenerGroup,
            instance.ValueHandler
        )
    end

    inherited.Setup(
        instance,
        instance.ValueHandler,
        instance.ListenerGroup
    )
end