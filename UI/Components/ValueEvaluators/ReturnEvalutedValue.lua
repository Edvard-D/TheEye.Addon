local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnValue = {}
local this = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnEvaluatedValue
local inherited = TheEyeAddon.UI.Objects.Components.ValueEvaluators.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ValueAction                 function(#VALUE#) return #VALUE# end
]]
function this:Setup(
    instance,
    UIObject,
    ValueAction
)

    inherited:Setup(
        instance,
        UIObject,
        this.Evalute
    )

    instance.ValueAction = ValueAction
end

function this:Evalute(value)
    return self:ValueAction(value)
end