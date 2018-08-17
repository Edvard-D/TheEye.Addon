TheEyeAddon.UI.Components.Icon = {}
local this = TheEyeAddon.UI.Components.Icon
local inherited = TheEyeAddon.UI.Components.Elements.Frame

local IconFactory = TheEyeAddon.UI.Factories.Icon


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    DisplayData =
    {
        iconObjectType = #ICON#TYPE#
        iconObjectID = #ICON#ID#
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
        instance,
        IconFactory
    )
end