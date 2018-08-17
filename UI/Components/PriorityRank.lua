TheEyeAddon.UI.Components.PriorityRank = {}
local this = TheEyeAddon.UI.Components.PriorityRank
local inherited = TheEyeAddon.UI.Components.Elements.ListenerValueChangeHandlers.IntegerKeyValueEventSender


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    ValueHandler =
    {
        validKeys =
        {
            [0] = #INT#
            #INT# = #INT#
        }
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

    instance.SortValueGet = this.SortValueGet
end

function this:SortValueGet()
    return self.ValueHandler.value
end