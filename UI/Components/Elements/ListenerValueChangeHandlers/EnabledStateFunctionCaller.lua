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
]]
function this.Setup(
    instance,
    uiObject,
    stateListener
)

    listener =
    {
        eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
        inputValues = { uiObject.key, "EnabledState" },
        isInternal = true,
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