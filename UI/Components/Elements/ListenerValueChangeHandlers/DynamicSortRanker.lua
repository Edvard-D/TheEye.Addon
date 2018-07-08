local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRanker = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRanker
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent
local SortRankSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Components.Elements.ListenerGroups#NAME#TEMPLATE#
    ValueHandler = #TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank#TEMPLATE#
}
]]


--[[ SETUP
    instance
    UIObject                    UIObject
]]
function this:Setup(
    instance,
    UIObject
)

    instance.OnSortRankChange = this.OnSortRankChange

    SortRankSetup(
        instance.ValueHandler,
        UIObject,
        instance.OnSortRankChange
    )

    inherited:Setup(
        instance,
        UIObject,
        instance.ListenerGroup
    )
end

function this:OnSortRankChange()
    SendCustomEvent("UIOBJECT_SORTRANK_CHANGED", self.UIObject)
end