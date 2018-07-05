local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueChangeHandlers.EnabledStateReactor = {}
local this = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.EnabledStateReactor
local inherited = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.Base

local SimpleStateSetup = TheEyeAddon.UI.Objects.Components.ValueHandlers.SimpleState
local ValueSetterSetup = TheEyeAddon.UI.Objects.Components.ListenerGroups.ValueSetter.Setup


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

    instance.ValueHandler = {}
    SimpleStateSetup(
        instance.ValueHandler,
        UIObject,
        this.OnEnabledChanged
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

function this:OnEnabledChanged(isEnabled)
    if isEnabled == true then
        self:OnEnable()
    else
        self:OnDisable()
    end
end