TheEye.Core.UI.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller = {}
local this = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.FrameStateFunctionCaller
local inherited = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.StateFunctionCaller


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
        inputValues = { "#SELF#UIOBJECT#KEY#", "Frame" },
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