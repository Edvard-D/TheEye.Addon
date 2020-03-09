TheEye.Core.UI.Elements.Base = {}
local this = TheEye.Core.UI.Elements.Base

local uiManager = TheEye.Core.Managers.UI


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

    instance.UIObject = uiManager.currentUIObject
    if instance ~= uiManager.currentComponent then
        instance.Component = uiManager.currentComponent
    end
end