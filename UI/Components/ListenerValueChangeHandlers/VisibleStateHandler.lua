local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Components.ListenerValueChangeHandlers.VisibleStateHandler = {}
local this = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.VisibleStateHandler
local inherited = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.KeyStateFunctionCaller

local EnabledStateReactorSetup = TheEyeAddon.UI.Components.ListenerValueChangeHandlers.EnabledStateReactor.Setup


--[[ #this#TEMPLATE#
{
    #inherited#TEMPLATE#
    -- @TODO add DisplayData Template
}
]]


--[[ SETUP
    instance
    UIObject                    UIObject
]]
function this:Setup(
    instance,
    UIObject
)
    
    inherited:Setup(
        instance,
        UIObject,
        this.Show, -- @TODO
        this.Hide -- @TODO
    )
    
    instance.OnEnable = this.OnEnable -- @TODO
    instance.OnDisable = this.OnDisable -- @TODO

    instance.EnabledStateReactor = {}
    EnabledStateReactorSetup(
        instance.EnabledStateReactor,
        UIObject,
        instance.OnEnable,
        instance.OnDisable
    )
end