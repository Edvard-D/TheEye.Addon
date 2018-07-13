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
            {
                eventEvaluatorKey = "UIOBJECT_ENABLED_CHANGED",
                inputValues = { uiObject.key }
            }
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
        instance.ValueHandler,
        instance.ListenerGroup
    )

    instance.EnabledStateListener = enabledStateListener

    instance.OnStateChange = this.OnStateChange

    instance:Activate()
end

function this:OnStateChange(isEnabled)
    if isEnabled == true then
        self.EnabledStateListener:OnEnable()
    else
        self.EnabledStateListener:OnDisable()
    end
end