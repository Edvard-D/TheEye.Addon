TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller = {}
local this = TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.EnabledStateFunctionCaller
local inherited = TheEyeAddon.UI.Elements.ListenerValueChangeHandlers.StateFunctionCaller


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    stateListener               { function OnEnable(), function OnDisable() }
    priority                    #INT#
]]
function this.Setup(
    instance,
    stateListener,
    priority
)

    listener =
    {
        eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
        inputValues = { "#SELF#UIOBJECT#KEY#", "EnabledState" },
        priority = priority,
        isInternal = true
    }

    inherited.Setup(
        instance,
        listener,
        stateListener,
        "OnEnable",
        "OnDisable"
    )

    instance:Activate()
end