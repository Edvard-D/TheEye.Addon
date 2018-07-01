local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnValue = {}
local this = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnValue
local inherited = TheEyeAddon.UI.Objects.Components.ValueEvaluators.Base

--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    Return                      function(#VALUE#) return #VALUE# end
]]
function this:Setup(
    instance,
    UIObject,
    Return
)

    inherited:Setup(
        instance,
        UIObject,
        this.Execute
    )

    instance.Return = Return
end

function this:Execute(value)
    returnValue = Return(value)
    return returnValue
end