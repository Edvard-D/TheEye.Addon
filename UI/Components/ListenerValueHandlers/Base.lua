local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueHandlers.Base = {}
local this = TheEyeAddon.UI.Components.ListenerValueHandlers.Base


--[[ #this#TEMPLATE#
{
    ValueHandler = #TheEyeAddon.UI.Objects.Components.ValueHandlers#NAME#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Objects.Components.ListenerGroups#NAME#TEMPLATE#
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

    instance.ValueHandler = IntegerKeyStateSetup:Setup(
        instance.ValueHandler or {},
        UIObject,
        this.OnStateChange
    )

    instance.ListenerGroup = StateBasedValueChangerSetup:Setup(
        instance.ListenerGroup or {},
        UIObject,
        instance.ValueHandler
    )
end

function this:OnStateChange(state)
    if state == true then
        self:OnValidKey()
    else
        self:OnInvalidKey()
    end
end