local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnEvaluatedValue = {}
local this = TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnEvaluatedValue
local inherited = TheEyeAddon.UI.Components.Elements.ValueEvaluators.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    ValueAction                 function(#VALUE#) return #VALUE# end
]]
function this.Setup(
    instance,
    uiObject,
    valueAction
)

    inherited.Setup(
        instance,
        uiObject,
        this.Evaluate
    )

    instance.ValueAction = valueAction
end

function this:Evaluate(value)
    return self:ValueAction(value)
end