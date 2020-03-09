TheEye.Core.UI.Elements.ListenerValueChangeHandlers.StateFunctionCaller = {}
local this = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.StateFunctionCaller
local inherited = TheEye.Core.UI.Elements.ListenerValueChangeHandlers.Base

local ValueChangeNotifierSetup = TheEye.Core.UI.Elements.ValueHandlers.ValueChangeNotifier.Setup
local ValueSetterSetup = TheEye.Core.UI.Elements.ListenerGroups.ValueSetter.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ SETUP
    instance
    listener                    #LISTENER#
    stateListener               { function #trueFunctionName#(), function #falseFunctionName#() }
    trueFunctionName            #STRING#
    falseFunctionName           #STRING#
]]
function this.Setup(
    instance,
    listener,
    stateListener,
    trueFunctionName,
    falseFunctionName
)

    instance.ValueHandler = {}
    ValueChangeNotifierSetup(
        instance.ValueHandler,
        instance,
        "OnStateChange",
        false
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
        instance.ValueHandler
    )

    inherited.Setup(
        instance,
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