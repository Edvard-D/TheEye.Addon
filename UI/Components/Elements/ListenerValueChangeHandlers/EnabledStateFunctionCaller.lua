local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller

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
    enabledStateListener        { function OnEnable(), function OnDisable() }
]]
function this.Setup(
    instance,
    uiObject,
    enabledStateListener
)

    instance.EnabledStateListener = enabledStateListener
    instance.OnStateChange = this.OnStateChange

    listener =
    {
        eventEvaluatorKey = "UIOBJECT_ENABLED_CHANGED",
        inputValues = { uiObject.key },
        isInternal = true,
    }

    inherited.Setup(
        instance,
        uiObject,
        listener,
        instance.OnStateChange
    )

    instance:Activate()
end

function this:OnStateChange(isEnabled)
    if isEnabled == true then
        self.EnabledStateListener:OnEnable()
    else
        self.EnabledStateListener:OnDisable()
    end
end