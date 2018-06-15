local TheEyeAddon = TheEyeAddon


local function RegisterToEvents(eventHandler)
    if eventHandler.frame == nil then
        eventHandler.frame = TheEyeAddon.UI.Objects.Factories.Frame:Create("Frame", nil, UIParent)
        eventHandler.frame:SetScript("OnEvent", eventHandler.HandleEvent)
    end

    for k,v in pairs(eventHandler.registerTo) do
        eventHandler.frame:RegisterEvent(v)
    end
end

function TheEyeAddon.EventHandlers:RegisterListener(eventHandler, listener)
    if table.hasvalue(eventHandler.listeners, listener) == false then
        table.insert(eventHandler.listeners, listener)

        eventHandler.listenerCount = eventHandler.listenerCount + 1
        if eventHandler.listenerCount == 1 then -- If the value was 0 before
            RegisterToEvents(eventHandler)
        end
    else
        error("Trying to add a duplicate listener to an event handler.")
    end
end

function TheEyeAddon.EventHandlers:UnregisterListener(eventHandler, listener)
    table.removevalue(eventHandler.listeners, listener)

    eventHandler.listenerCount = eventHandler.listenerCount - 1
    if eventHandler.listenerCounter == 0 then -- If the value was greater than 0 before
        eventHandler.frame:UnregisterAllEvents()
        eventHandler.frame:SetScript("OnEvent", nil)
    elseif eventHandler.listenerCounter < 0 then
        error("Registered listeners set to " ..
            tostring(eventHandler.listenerCount) ..
            " but should never be below 0.")
    end
end