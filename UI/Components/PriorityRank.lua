TheEyeAddon.UI.Components.PriorityRank = {}
local this = TheEyeAddon.UI.Components.PriorityRank

local DynamicSortRankSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRank.Setup
local StaticValueSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.StaticValue.Setup


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
        ValueHandler = #TheEyeAddon.UI.Components.Elements.ValueHandlers.StaticValue#TEMPLATE#
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
        StaticValueSetup(
            instance.ValueHandler,
            uiObject
        )
    end
end