local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRank = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRank
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent
local SortRankSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger#TEMPLATE#
    ValueHandler = #TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank#TEMPLATE#
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
]]
function this:Setup(
    instance,
    uiObject
)

    instance.OnSortRankChange = this.OnSortRankChange

    SortRankSetup(
        instance.ValueHandler,
        uiObject,
        instance.OnSortRankChange
    )

    inherited:Setup(
        instance,
        uiObject,
        instance.ListenerGroup
    )
end

function this:OnSortRankChange()
    SendCustomEvent("UIOBJECT_SORTRANK_CHANGED", self.UIObject)
end