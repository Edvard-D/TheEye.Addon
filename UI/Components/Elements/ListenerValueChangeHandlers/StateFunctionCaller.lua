TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local ValueChangeNotifierSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifier.Setup
local ValueSetterSetup = TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueSetter.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
    listener                    #LISTENER#
    stateListener               { function #trueFunctionName#(), function #falseFunctionName#() }
    trueFunctionName            #STRING#
    falseFunctionName           #STRING#
]]
function this.Setup(
    instance,
    uiObject,
    listener,
    stateListener,
    trueFunctionName,
    falseFunctionName
)

    instance.ValueHandler = {}
    ValueChangeNotifierSetup(
        instance.ValueHandler,
        uiObject,
        instance,
        "OnStateChange"
    )

    instance.ListenerGroup =
    {
        Listeners =
        {
            listener
        }
    }
    ValueSetterSetup(
        instance.ListenerGroup,
        uiObject,
        instance.ValueHandler
    )

    inherited.Setup(
        instance,
        uiObject,
        instance.ValueHandler,
        instance.ListenerGroup
    )

    instance.OnStateChange = this.OnStateChange
    instance.StateListener = stateListener
    instance.stateFunctionNames =
    {
        [true] = trueFunctionName,
        [false] = falseFunctionName
    }
end

function this:OnStateChange(state)
    self.StateListener[self.stateFunctionNames[state]](self.StateListener)
end