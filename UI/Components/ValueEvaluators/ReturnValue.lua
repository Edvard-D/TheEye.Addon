local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnValue = {}
local this = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnValue

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      Return                      function(value) return returnValue end
function this:Setup(
    instance,
    UIObject,
    Return
)

    TheEyeAddon.UI.Objects.Components.ValueEvaluators.Base:Setup(
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