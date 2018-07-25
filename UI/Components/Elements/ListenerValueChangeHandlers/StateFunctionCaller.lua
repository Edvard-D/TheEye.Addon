local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.StateFunctionCaller
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local SimpleStateSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SimpleState.Setup
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
    OnStateChange               fucntion(#BOOL#)
]]
function this.Setup(
    instance,
    uiObject,
    listener,
    OnStateChange
)

    instance.ValueHandler = {}
    SimpleStateSetup(
        instance.ValueHandler,
        uiObject,
        instance
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

    instance.OnStateChange = OnStateChange
end