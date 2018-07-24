local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Child = {}
local this = TheEyeAddon.UI.Components.Child


--[[ #this#TEMPLATE#
{
    parentKey = #UIOBJECT#KEY#
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

    instance.UIObject = uiObject
end