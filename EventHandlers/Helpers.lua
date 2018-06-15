local TheEyeAddon = TheEyeAddon


local function RegisterToEvents(eventHandler)
    if eventHandler.frame == nil then
        TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", nil, UIParent)
    end

    for k,v in pairs(eventHandler.registerTo) do
        eventHandler.frame:RegisterEvent(v)
    end
end

function TheEyeAddon.EventHandlers:RegisterListener(eventHandler, listener)
    if table.hasvalue(eventHandler.listeners, listener) == false then
        table.insert(eventHandler.listeners, listener)

        eventHandler.listenerCount = eventHandler.listenerCount + 1
        if eventHandler.listenerCount == 1 then
            RegisterToEvents(eventHandler)
        end
    else
        error("Trying to add a duplicate listener to an event handler.")
    end
end

function TheEyeAddon.EventHandlers:UnregisterListener(eventHandler, listener)
    table.removevalue(eventHandler.listeners, listener)

    eventHandler.listenerCount = eventHandler.listenerCount - 1
    if eventHandler.listenerCounter == 0 then
        eventHandler.frame:UnregisterAllEvents()
    end
end