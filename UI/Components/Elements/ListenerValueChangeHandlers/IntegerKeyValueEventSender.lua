TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.IntegerKeyValueEventSender = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.IntegerKeyValueEventSender
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local IntegerKeyValueSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.IntegerKeyValue.Setup
local StateBasedIntChangerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedIntChanger.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = #TheEyeAddon.UI.Components.Elements.ValueHandlers.IntegerKeyValue#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedIntChanger#TEMPLATE#
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