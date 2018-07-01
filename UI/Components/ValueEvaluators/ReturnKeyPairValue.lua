local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue = {}
local this = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnKeyPairValue
local inherited = TheEyeAddon.UI.Objects.Components.ValueEvaluators.ReturnValue


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    keyPairs                    { #VALUE# = #VALUE# }
]]
function this:Setup(
    instance,
    UIObject,
    keyPairs
)

    inherited:Setup(
        instance,
        UIObject,
        this.GetKeyValue
    )

    instance.keyPairs = keyPairs
end

function this:GetKeyValue(value)
    return keyPairs[value]
end