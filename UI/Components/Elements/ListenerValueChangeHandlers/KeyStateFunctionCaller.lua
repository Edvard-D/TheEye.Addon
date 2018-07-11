local TheEyeAddon = TheEyeAddon
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
    uiObject                    UIObject
    onValidKey                  function()
    onInvalidKey                function()
]]
function this:Setup(
    instance,
    uiObject,
    onValidKey,
    onInvalidKey
)
    
    instance.OnStateChange = this.OnStateChange
    instance.ValueHandler = instance.ValueHandler or {}
    IntegerKeyStateSetup(
        instance.ValueHandler,
        uiObject,
        instance.OnStateChange
    )

    instance.ListenerGroup = instance.ListenerGroup or {}
    StateBasedIntChangerSetup(
        instance.ListenerGroup,
        uiObject,
        instance.ValueHandler
    )

    inherited:Setup(
        instance,
        uiObject,
        instance.ListenerGroup
    )

    instance.OnValidKey = onValidKey
    instance.OnInvalidKey = onInvalidKey
end

function this:OnStateChange(state)
    if state == true then
        self:OnValidKey()
    else
        self:OnInvalidKey()
    end
end