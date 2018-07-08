local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.KeyStateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local IntegerKeyStateSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.IntegerKeyState.Setup
local StateBasedValueChangerSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedValueChanger.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler = #TheEyeAddon.UI.Components.Elements.ValueHandlers.IntegerKeyState#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Components.Elements.ListenerGroups.StateBasedValueChanger#TEMPLATE#
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