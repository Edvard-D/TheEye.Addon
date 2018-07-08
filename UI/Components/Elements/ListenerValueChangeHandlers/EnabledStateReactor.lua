local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateReactor = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateReactor
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local SimpleStateSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SimpleState.Setup
local ValueSetterSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueSetter.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    UIObject                    UIObject
    OnEnable                    function()
    OnDisable                   function()
]]
function this:Setup(
    instance,
    UIObject,
    OnEnable,
    OnDisable
)

    instance.OnEnabledChange = this.OnEnabledChange

    instance.ValueHandler = {}
    SimpleStateSetup(
        instance.ValueHandler,
        UIObject,
        instance.OnEnabledChange
    )

    instance.ListenerGroup =
    {
        Listeners =
        {
            evaluatorName = "UIObject_Visible",
            inputValues = { UIObject.key }
        }
    }
    ValueSetterSetup(
        ListenerGroup,
        UIObject,
        instance.ValueHandler
    )

    inherited:Setup(
        instance,
        UIObject,
        instance.ListenerGroup
    )

    instance.OnEnable = OnEnable
    instance.OnDisable = OnDisable
end

function this:OnEnabledChange(isEnabled)
    if isEnabled == true then
        self:OnEnable()
    else
        self:OnDisable()
    end
end