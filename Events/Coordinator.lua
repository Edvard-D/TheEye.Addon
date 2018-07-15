local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = {}
local this = TheEyeAddon.Events.Coordinator
local Listeners = {}

local frame = CreateFrame("Frame", nil, UIParent)
local table = table


-- Event Handling
local function RelayEvent(self, eventName, ...)
    --print ("Coordinator RelayEvent    " .. eventName) -- DEBUG
    local listeners = Listeners[eventName]
    for i=1,#listeners do
        -- Nil is checked since it's possible for a listener earlier in the array to
        -- cause a listener later in the array to be deregistered before its OnEvent
        -- function is called.
        if listeners[i] ~= nil then
            listeners[i]:OnEvent(eventName, ...)
        end
    end
end
frame:SetScript("OnEvent", RelayEvent)


-- Register
local function ListenerRegister(listener, eventName, isGameEvent)
    if Listeners[eventName] == nil then
        Listeners[eventName] = { listener }
        --print ("RegisterEvent    " .. eventName) -- DEBUG

        if isGameEvent == true then
            frame:RegisterEvent(eventName)
        end
    else
        table.insert(Listeners[eventName], listener)
    end

    local listeners = Listeners[eventName]
    if listeners.listenerCount == nil then
        listeners.listenerCount = 0
    end
    listeners.listenerCount = listeners.listenerCount + 1
end

local function ListenersRegister(listener, events, isGameEvent)
    for i=1,#events do
        ListenerRegister(listener, events[i], isGameEvent)
    end
end

function this.Register(listener)
    if listener.gameEvents ~= nil then
        ListenersRegister(listener, listener.gameEvents, true)
    end

    if listener.customEvents ~= nil then
        ListenersRegister(listener, listener.customEvents, false)
    end
end


-- Deregister
local function ListenerDeregister(listener, eventName, isGameEvent)
    local listeners = Listeners[eventName]
    table.removevalue(listeners, listener)
    
    listeners.listenerCount = listeners.listenerCount - 1
    if listeners.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        Listeners[eventName] = nil
        listeners = nil
        --print ("DeregisterEvent    " .. eventName) -- DEBUG

        if isGameEvent == true then
            frame:UnregisterEvent(eventName)
        end
    end
end

local function ListenersDeregister(listener, events, isGameEvent)
    for i=1,#events do
        ListenerDeregister(listener, events[i], isGameEvent)
    end
end

function this.Deregister(listener)
    if listener.gameEvents ~= nil then
        ListenersDeregister(listener, listener.gameEvents, true)
    end
    
    if listener.customEvents ~= nil then
        ListenersDeregister(listener, listener.customEvents, false)
    end
end


-- Custom Events
function this.SendCustomEvent(eventName, ...)
    if Listeners[eventName] ~= nil then
        RelayEvent(nil, eventName, ...)
    end
end