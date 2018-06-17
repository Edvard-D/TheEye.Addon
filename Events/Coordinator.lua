local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = { Handlers = {} }
local Handlers = TheEyeAddon.Events.Coordinator.Handlers


function TheEyeAddon.Events.Coordinator:HandleEvent(event)
    for i,handler in ipairs(Handlers.event) do
        TheEyeAddon.Events.Handlers:EvaluateState(handler, event)
    end
end