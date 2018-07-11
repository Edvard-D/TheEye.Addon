local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnKeyPairValue = {}
local this = TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnKeyPairValue
local inherited = TheEyeAddon.UI.Components.Elements.ValueEvaluators.ReturnValue


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    uiObject                    UIObject
    keyPairs                    { #VALUE# = #VALUE# }
]]
function this:Setup(
    instance,
    uiObject,
    keyPairs
)

    inherited:Setup(
        instance,
        uiObject,
        this.GetKeyValue
    )

    instance.keyPairs = keyPairs
end

function this:GetKeyValue(value)
    return keyPairs[value]
end