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
    uiObject                    UIObject
    onEnable                    function()
    onDisable                   function()
]]
function this.Setup(
    instance,
    uiObject,
    onEnable,
    onDisable
)

    instance.OnEnabledChange = this.OnEnabledChange

    instance.ValueHandler = {}
    SimpleStateSetup(
        instance.ValueHandler,
        uiObject,
        instance.OnEnabledChange
    )

    instance.ListenerGroup =
    {
        Listeners =
        {
            evaluatorName = "UIObject_Visible",
            inputValues = { uiObject.key }
        }
    }
    ValueSetterSetup(
        ListenerGroup,
        uiObject,
        instance.ValueHandler
    )

    inherited.Setup(
        instance,
        uiObject,
        instance.ListenerGroup
    )

    instance.OnEnable = onEnable
    instance.OnDisable = onDisable
end

function this:OnEnabledChange(isEnabled)
    if isEnabled == true then
        self:OnEnable()
    else
        self:OnDisable()
    end
end