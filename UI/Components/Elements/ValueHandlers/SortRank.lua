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
    uiObject                    UIObject
    onSortRankChange            function(#INT#)
]]
function this.Setup(
    instance,
    uiObject,
    onSortRankChange
)

    inherited.Setup(
        instance,
        uiObject,
        nil,
        onSortRankChange,
        instance.defaultValue
    )
end