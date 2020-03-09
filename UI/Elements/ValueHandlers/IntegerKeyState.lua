TheEye.Core.UI.Elements.ValueHandlers.IntegerKeyState = {}
local this = TheEye.Core.UI.Elements.ValueHandlers.IntegerKeyState
local inherited = TheEye.Core.UI.Elements.ValueHandlers.KeyState


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    validKeys = { #INT# = true }
}
]]


--[[ #SETUP#
    instance
    stateChangeListener         function(#BOOL#)
]]
function this.Setup(
    instance,
    stateChangeListener
)

    inherited.Setup(
        instance,
        this.Add,
        0,
        stateChangeListener
    )
end

function this:Add(value)
    return self[self.valueKey] + value
end