local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroup.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroup.Base


function this:Create(
    -- this
    OnEvaluate,     -- function
    ListeningTo     -- table: structure defined by Evaluators
)
    local instance = {}

    instance.ListeningTo = ListeningTo

    return instance
end