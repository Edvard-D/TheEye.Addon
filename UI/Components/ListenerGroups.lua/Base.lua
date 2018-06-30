local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroup.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroup.Base


function this:Setup(
    instance,
    -- this
    OnEvaluate,     -- function
    Listeners       -- table: structure defined by Evaluators
)
    local instance = {}

    instance.Listeners = Listeners


    
    return instance
end