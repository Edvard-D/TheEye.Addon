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
    evaluate                    function(#VALUE#)
]]
function this.Setup(
    instance,
    uiObject,
    evaluate
)

    instance.UIObject = uiObject
    instance.Evaluate = evaluate
end