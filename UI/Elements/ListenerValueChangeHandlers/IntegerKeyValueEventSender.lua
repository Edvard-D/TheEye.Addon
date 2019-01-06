TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.IntegerKeyValueEventSender = {}
local this = TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.IntegerKeyValueEventSender
local inherited = TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.Base

local IntegerKeyValueSetup = TheEyeAddon.UI.Elements.ValueHandlers.IntegerKeyValue.Setup
local StateBasedIntChangerSetup = TheEyeAddon.UI.Elements.ListenerGroups.StateBasedIntChanger.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = #TheEyeAddon.UI.Elements.ValueHandlers.IntegerKeyValue#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Elements.ListenerGroups.StateBasedIntChanger#TEMPLATE#
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