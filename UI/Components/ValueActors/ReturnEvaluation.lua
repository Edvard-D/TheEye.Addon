local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueActors.ReturnEvaluation = {}
local this = TheEyeAddon.UI.Objects.Components.ValueActors.ReturnEvaluation

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      Evaluate                    function(value) return evaluation end
function this:Setup(
    instance,
    UIObject,
    Evaluate
)

    TheEyeAddon.UI.Objects.Components.ValueActors.Base:Setup(
        instance,
        UIObject,
        this.Execute
    )

    instance.Evaluate = Evaluate
end

function this:Execute(value)
    evaluation = Evaluate(value)
end