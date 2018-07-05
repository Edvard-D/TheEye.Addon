local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueChangeHandlers.KeyStateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.KeyStateFunctionCaller
local inherited = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.Base

local IntegerKeyStateSetup = TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState.Setup
local StateBasedValueChangerSetup = TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = #TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger#TEMPLATE#
}
]]


--[[ SETUP
    instance
    UIObject                    UIObject
    OnValidKey                  function()
    OnInvalidKey                function()
]]
function this:Setup(
    instance,
    UIObject,
    OnValidKey,
    OnInvalidKey
)
    
    instance.UIObject = UIObject

    instance.ValueHandler = instance.ValueHandler or {}
    local ValueHandler = IntegerKeyStateSetup(
        instance.ValueHandler,
        UIObject,
        this.OnStateChange
    )

    instance.ListenerGroup = instance.ListenerGroup or {}
    StateBasedValueChangerSetup(
        instance.ListenerGroup,
        UIObject,
        instance.ValueHandler
    )

    inherited:Setup(
        instance,
        UIObject,
        instance.ListenerGroup
    )
end

function this:OnStateChange(state)
    if state == true then
        self:OnValidKey()
    else
        self:OnInvalidKey()
    end
end