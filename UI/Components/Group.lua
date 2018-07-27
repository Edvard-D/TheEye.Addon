TheEyeAddon.UI.Components.Group = {}
local this = TheEyeAddon.UI.Components.Group
local inherited = TheEyeAddon.UI.Components.Frame

local GroupFactory = TheEyeAddon.UI.Factories.Group


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
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
        GroupFactory
    )
end