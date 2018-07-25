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
        eventEvaluatorKey = "UIOBJECT_ENABLED_CHANGED",
        inputValues = { uiObject.key },
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