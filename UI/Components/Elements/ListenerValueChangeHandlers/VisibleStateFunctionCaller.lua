TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.VisibleStateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller


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