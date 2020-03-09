TheEye.Core.UI.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller = {}
local this = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller
local inherited = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.StateFunctionCaller


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    stateListener               { function OnShow(), function OnHide() }
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
        inputValues = { "#SELF#UIOBJECT#KEY#", "VisibleState" },
        priority = priority,
        isInternal = true
    }

    inherited.Setup(
        instance,
        listener,
        stateListener,
        "OnShow",
        "OnHide"
    )
    
    instance:Activate()
end