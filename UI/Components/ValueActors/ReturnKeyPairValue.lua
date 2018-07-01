local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueActors.ReturnKeyPairValue = {}
local this = TheEyeAddon.UI.Objects.Components.ValueActors.ReturnKeyPairValue

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

    TheEyeAddon.UI.Objects.Components.ValueActors.ReturnValue:Setup(
        instance,
        UIObject,
        this.Return -- @TODO
    )

    instance.keyPairs = keyPairs
end

function this:Return(value)
    return keyPairs[value]
end