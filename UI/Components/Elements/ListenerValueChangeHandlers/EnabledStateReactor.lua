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
    enabledStateListener         { function OnEnable(), function OnDisable() }
]]
function this.Setup(
    instance,
    uiObject,
    enabledStateListener
)

    instance.ValueHandler = {}
    SimpleStateSetup(
        instance.ValueHandler,
        uiObject,
        instance
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
        instance.ListenerGroup,
        uiObject,
        instance.ValueHandler
    )

    inherited.Setup(
        instance,
        uiObject,
        instance.ListenerGroup
    )

    instance.EnabledStateListener = enableStateListener
end

function this:OnStateChange(isEnabled)
    if isEnabled == true then
        self.EnableStateListener:OnEnable()
    else
        self.EnableStateListener:OnDisable()
    end
end