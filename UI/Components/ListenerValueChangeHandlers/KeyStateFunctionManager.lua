local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueChangeHandlers.KeyStateFunctionManager = {}
local this = TheEyeAddon.UI.Components.ListenerValueHandlers.KeyStateFunctionManager
local inherited = TheEyeAddon.UI.Components.ListenerValueHandlers.Base

local IntegerKeyStateSetup = TheEyeAddon.UI.Objects.Components.ValueHandlers.IntegerKeyState.Setup
local StateBasedValueChangerSetup = TheEyeAddon.UI.Objects.Components.ListenerGroups.StateBasedValueChanger.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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

    local ValueHandler = IntegerKeyStateSetup(
        instance.ValueHandler or {},
        UIObject,
        this.OnStateChange
    )

    local ListenerGroup = StateBasedValueChangerSetup(
        instance.ListenerGroup or {},
        UIObject,
        instance.ValueHandler
    )

    inherited:Setup(
    instance,
    UIObject,
    ValueHandler,
    ListenerGroup
)
end

function this:OnStateChange(state)
    if state == true then
        self:OnValidKey()
    else
        self:OnInvalidKey()
    end
end