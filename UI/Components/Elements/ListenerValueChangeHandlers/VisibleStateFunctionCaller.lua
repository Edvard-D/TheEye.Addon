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
    uiObject                    UIObject
    stateListener               { function OnShow(), function OnHide() }
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
        inputValues = { uiObject.key, "VisibleState" },
        priority = priority,
        isInternal = true
    }

    inherited.Setup(
        instance,
        uiObject,
        listener,
        stateListener,
        "OnShow",
        "OnHide"
    )
    
    instance:Activate()
end