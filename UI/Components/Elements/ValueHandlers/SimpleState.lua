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
    UIObject                    UIObject
    OnStateChange               function()
]]
function this:Setup(
    instance,
    UIObject,
    OnStateChange
)

    inherited:Setup(
        instance,
        UIObject,
        nil,
        nil,
        OnStateChange,
        false
    )
end