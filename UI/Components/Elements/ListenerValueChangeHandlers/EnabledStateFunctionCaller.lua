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
    stateListener               { function OnEnable(), function OnDisable() }
]]
function this.Setup(
    instance,
    uiObject,
    stateListener
)

    instance.StateListener = stateListener
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
        self.StateListener:OnEnable()
    else
        self.StateListener:OnDisable()
    end
end