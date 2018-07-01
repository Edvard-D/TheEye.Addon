local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue = {}
local this = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue

--[[ TEMPLATE
nil
]]


-- SETUP
--      instance
--      UIObject                    UIObject
--      keyPairs                    table { [key] = value }
function this:Setup(
    instance,
    UIObject,
    keyPairs
)

    TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnValue:Setup(
        instance,
        UIObject,
        this.Return
    )

    instance.keyPairs = keyPairs
end

function this:Return(value)
    return keyPairs[value]
end