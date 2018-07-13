local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.SimpleState = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.SimpleState
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    stateChangeListener         { OnStateChange(state) }
]]
function this.Setup(
    instance,
    uiObject,
    stateChangeListener
)

    inherited.Setup(
        instance,
        uiObject,
        nil,
        nil,
        this.OnValueChange,
        false
    )

    instance.StateChangeListener = stateChangeListener
end

function this:OnValueChange(state)
    self.StateChangeListener:OnStateChange(state)
end