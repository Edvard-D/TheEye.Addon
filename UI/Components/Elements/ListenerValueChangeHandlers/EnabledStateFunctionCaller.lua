TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
    stateListener               { function OnEnable(), function OnDisable() }
    priority                    #INT#
]]
function this.Setup(
    instance,
    uiObject,
    stateListener,
    priority
)

    listener =
    {
        eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
        inputValues = { uiObject.key, "EnabledState" },
        priority = priority,
    }

    inherited.Setup(
        instance,
        uiObject,
        listener,
        stateListener,
        "OnEnable",
        "OnDisable"
    )

    instance:Activate()
end