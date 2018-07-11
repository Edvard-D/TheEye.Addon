local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyState = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.KeyState
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    validKeys = { #VALUE# = true }
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    valueAction                 function(#VALUE#)
    defaultValue                #VALUE#
    stateChangeListener         table { OnStateChange = function(state) }
]]
function this.Setup(
    instance,
    uiObject,
    valueAction,
    defaultValue,
    stateChangeListener
)

    inherited.Setup(
        instance,
        uiObject,
        valueAction,
        this.OnValueChange,
        defaultValue
    )

    instance.StateChangeListener = stateChangeListener
    instance.state = nil
end

function this:OnValueChange()
    local state = self.validKeys[self.value]

    if self.state ~= state then
        self.state = state
        self.StateChangeListener:OnStateChange(self.state)
    end
end