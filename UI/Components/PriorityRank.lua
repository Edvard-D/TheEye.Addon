local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.PriorityRank = {}
local this = TheEyeAddon.UI.Components.PriorityRank

local DynamicSortRankSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRank.Setup
local SortRankSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank.Setup


--[[ #this#TEMPLATE#
{
    isDynamic = #BOOL#
}

#isDynamic#TRUE#
{
    #this#TEMPLATE#
    {
        #TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRank#TEMPLATE#
    }
}

#isDynamic#FALSE#
{
    #this#TEMPLATE#
    {
        #TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank#TEMPLATE#
    }
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

    if instance.isDynamic == true then
        DynamicSortRankSetup:Setup(
            instance,
            UIObject
        )
    else
        SortRankSetup:Setup(
            instance,
            UIObject,
            nil
        )
    end
end