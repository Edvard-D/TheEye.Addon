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
        ValueHandler = #TheEyeAddon.UI.Components.Elements.ValueHandlers.SortRank#TEMPLATE#
    }
}
]]


--[[ SETUP
    instance
    uiObject                    UIObject
]]
function this.Setup(
    instance,
    uiObject
)

    if instance.isDynamic == true then
        DynamicSortRankSetup(
            instance,
            uiObject
        )
    else
        SortRankSetup(
            instance.ValueHandler,
            uiObject,
            nil
        )
    end
end