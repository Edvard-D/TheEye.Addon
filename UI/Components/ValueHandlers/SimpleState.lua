local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.SimpleState = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.SimpleState
local inherited = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base


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