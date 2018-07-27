TheEyeAddon.UI.Components.Icon = {}
local this = TheEyeAddon.UI.Components.Icon
local inherited = TheEyeAddon.UI.Components.Frame

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
    uiObject                    UIObject
]]
function this.Setup(
    instance,
    uiObject
)

    inherited.Setup(
        instance,
        uiObject,
        IconFactory
    )
end