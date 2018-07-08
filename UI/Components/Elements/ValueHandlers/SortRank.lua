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
    OnSortRankChange            function(#INT#)
]]
function this:Setup(
    instance,
    UIObject,
    OnSortRankChange
)

    inherited:Setup(
        instance,
        UIObject,
        nil,
        nil,
        OnSortRankChange,
        instance.defaultValue
    )
end