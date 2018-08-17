TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    stateListener               { function OnClaim(), function OnRelease() }
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
        inputValues = { uiObject.key, "Frame" },
        priority = priority,
        isInternal = true
    }

    inherited.Setup(
        instance,
        listener,
        stateListener,
        "OnClaim",
        "OnRelease"
    )
    
    instance:Activate()
end