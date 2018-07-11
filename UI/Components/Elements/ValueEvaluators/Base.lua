local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueEvaluators.Base = {}
local this = TheEyeAddon.UI.Components.Elements.ValueEvaluators.Base


--[[ #this#TEMPLATE#
{
    nil
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    evalute                     function(#VALUE#)
]]
function this:Setup(
    instance,
    uiObject,
    evalute
)

    instance.UIObject = uiObject
    instance.Evalute = evalute
end