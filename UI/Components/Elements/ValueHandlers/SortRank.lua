local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank = {}
local this = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank
local inherited = TheEyeAddon.UI.Components.Elements.ValueHandlers.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    defaultValue = #INT#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    OnValueChange               function(#VALUE#)
]]
function this:Setup(
    instance,
    UIObject,
    OnValueChange
)

    inherited:Setup(
        instance,
        UIObject,
        nil,
        nil,
        OnValueChange,
        instance.defaultValue
    )
end