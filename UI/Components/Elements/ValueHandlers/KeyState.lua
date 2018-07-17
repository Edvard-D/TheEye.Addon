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
        this.OnActivate,
        this.OnDeactivate,
        valueAction,
        this.OnValueChange,
        defaultValue
    )

    instance.StateChangeListener = stateChangeListener
    instance.state = false
end

function this:OnActivate()
    self:OnValueChange(self:ValueAction(self.defaultValue))
end

function this:OnDeactivate()
    if self.state ~= false then
        self.state = false
        self.StateChangeListener:OnStateChange(false)
    end
end

function this:OnValueChange(value)
    local state = self.validKeys[value] or false

    print (self.UIObject.key .. "    OnValueChange value: " .. tostring(value)) -- @DEBUG
    if self.state ~= state then
        self.state = state
        self.StateChangeListener:OnStateChange(self.state)
    end
end