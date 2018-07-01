local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger = {}
local this = TheEyeAddon.UI.Objects.Components.Listeners.ValueChanger
local inherited = TheEyeAddon.UI.Objects.Components.Listeners.Base


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
}
]]


--[[ #SETUP#
    instance
    UIObject                    UIObject
    ListenerGroup               ListenerGroup
]]
function this:Setup(
    instance,
    UIObject,
    ListenerGroup
)

    inherited:Setup(
        instance,
        UIObject,
        ListenerGroup,
        this.Register,
        this.Unregister
    )
end

function this:Register()
    RegisterListener(instance.evaluatoryKey, instance)
end

function this:Unregister()
    UnregisterListener(evaluatorName, listener)
end