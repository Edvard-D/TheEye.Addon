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
    sortRankChangeListener      { OnSortRankChange(#INT#) }
]]
function this.Setup(
    instance,
    uiObject,
    sortRankChangeListener
)

    inherited.Setup(
        instance,
        uiObject,
        nil,
        nil,
        nil,
        this.OnValueChange,
        instance.defaultValue
    )

    instance.SortRankChangeListener = sortRankChangeListener
end

function this:OnValueChange(value)
    sortRankChangeListener:OnSortRankChange(value)
end