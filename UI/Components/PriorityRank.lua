TheEyeAddon.UI.Components.PriorityRank = {}
local this = TheEyeAddon.UI.Components.PriorityRank
local inherited = TheEyeAddon.UI.Components.Elements.Base

local DynamicSortRankSetup = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.DynamicSortRank.Setup
local StaticValueSetup = TheEyeAddon.UI.Components.Elements.ValueHandlers.StaticValue.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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
]]
function this.Setup(
    instance
)

    inherited.Setup(
        instance
    )

    if instance.isDynamic == true then
        DynamicSortRankSetup(
            instance
        )
    else
        StaticValueSetup(
            instance.ValueHandler
        )
    end

    instance.SortValueGet = this.SortValueGet
end

function this:SortValueGet()
    return self.ValueHandler.value
end