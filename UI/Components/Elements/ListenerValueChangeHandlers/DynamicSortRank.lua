TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRank = {}
local this = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRank
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.Base

local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent
local ValueChangeNotifierSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifier.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ListenerGroup = #TheEyeAddon.UI.Components.Elements.ListenerGroups.ValueChanger#TEMPLATE#
    ValueHandler =
    {
        #TheEyeAddon.UI.Components.Elements.ValueHandlers.ValueChangeNotifier#TEMPLATE#
        defaultValue = #NUMBER#
    }
}
]]


--[[ SETUP
    instance
]]
function this.Setup(
    instance
)

    instance.OnSortRankChange = this.OnSortRankChange
    ValueChangeNotifierSetup(
        instance.ValueHandler,
        instance,
        "OnSortRankChange",
        instance.ValueHandler.defaultValue
    )

    inherited.Setup(
        instance,
        instance.ValueHandler,
        instance.ListenerGroup
    )
end

function this:OnSortRankChange()
    SendCustomEvent("UIOBJECT_SORTRANK_CHANGED", self.UIObject)
end