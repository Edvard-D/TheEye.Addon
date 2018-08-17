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
    valueAction                 function(#VALUE#)
    defaultValue                #VALUE#
    stateChangeListener         table { OnStateChange = function(state) }
]]
function this.Setup(
    instance,
    valueAction,
    defaultValue,
    stateChangeListener
)

    inherited.Setup(
        instance,
        this.OnActivate,
        this.OnDeactivate,
        valueAction,
        this.OnValueChange,
        defaultValue,
        "key"
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

function this:OnValueChange(key)
    local state = self.validKeys[key] or false

    if TheEyeAddon.Tags.UIObjectHasTag(self.UIObject, "HUD") == true then
        --print (self.UIObject.key .. "    " .. self.Component.key .. "    OnValueChange key: " .. tostring(key)) -- @DEBUG
    end
    
    if self.state ~= state then
        self.state = state
        self.StateChangeListener:OnStateChange(self.state)
    end
end

function this:ValueGet()
    return self.state
end