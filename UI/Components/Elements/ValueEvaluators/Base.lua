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
    UIObject                    UIObject
    Evalute                     function(#VALUE#)
]]
function this:Setup(
    instance,
    UIObject,
    Evalute
)

    instance.UIObject = UIObject
    instance.Evalute = Evalute
end