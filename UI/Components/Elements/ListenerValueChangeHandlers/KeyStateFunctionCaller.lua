TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local IntegerKeyStateSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.IntegerKeyState.Setup
local StateBasedIntChangerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedIntChanger.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = #TheEyeAddon.UI.Components.Elements.ValueHandlers.IntegerKeyState#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedIntChanger#TEMPLATE#
}
]]


--[[ SETUP
    instance
    onValidKey                  function()
    onInvalidKey                function()
]]
function this.Setup(
    instance,
    onValidKey,
    onInvalidKey
)
    
    IntegerKeyStateSetup(
        instance.ValueHandler,
        instance
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

    instance.OnValidKey = onValidKey
    instance.OnInvalidKey = onInvalidKey
    
    instance.OnStateChange = this.OnStateChange
end

function this:OnStateChange(state)
    if state == true then
        self:OnValidKey()
    else
        self:OnInvalidKey()
    end
end