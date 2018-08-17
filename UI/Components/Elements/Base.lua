TheEyeAddon.UI.Components.Elements.Base = {}
local this = TheEyeAddon.UI.Components.Elements.Base

local Objects = TheEyeAddon.UI.Objects


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ #SETUP#
    instance
]]
function this.Setup(
    instance
)

    instance.UIObject = Objects.currentUIObject
    if instance ~= Objects.currentComponent then
        instance.Component = Objects.currentComponent
    end
end