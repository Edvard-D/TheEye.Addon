TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifiers.State = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifiers.State
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifiers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    stateChangeListener         { function OnStateChange(#BOOL#) }
]]
function this.Setup(
    instance,
    uiObject,
    stateChangeListener
)

    inherited.Setup(
        instance,
        uiObject,
        stateChangeListener,
        "OnStateChange"
    )
end