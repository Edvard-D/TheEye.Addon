local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = {}
local this = TheEyeAddon.Events.Coordinator
this.Listeners = {}
local Listeners = this.Listeners

local frame = CreateFrame("Frame", nil, UIParent)
local table = table


-- Event Handling
local function RelayEvent(eventName, ...)
    print ("Coordinator RelayEvent    " .. eventName) -- DEBUG
    local listeners = Listeners[eventName]
    for i=1,#listeners do
        listeners[i]:Notify(eventName, ...)
    end
end
frame:SetScript("OnEvent", RelayEvent)


-- Register
local function ListenerRegister(listener, eventName, isGameEvent)
    if listeners[eventName] == nil then
        listeners[eventName] = { listener }
        print ("RegisterEvent    " .. eventName) -- DEBUG

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

function this:Register(listener)
    if listener.gameEvents ~= nil then
        ListenersRegister(listener, listener.gameEvents, true)
    end

    if listener.customEvents ~= nil then
        ListenersRegister(listener, listener.gameEvents, false)
    end
end


-- Unregister
local function ListenerUnregister(listener, eventName, isGameEvent)
    local listeners = Listeners[eventName]
    table.removevalue(listeners, listener)
    
    listeners.listenerCount = listeners.listenerCount - 1
    if listeners.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        Listeners[eventName] = nil
        listeners = nil
        print ("UnregisterEvent    " .. eventName) -- DEBUG

        if isGameEvent == true then
            frame:UnregisterEvent(eventName)
        end
    end
end

local function ListenersUnregister(listener, events, isGameEvent)
    for i=1,#events do
        ListenerUnregister(listener, events[i], isGameEvent)
    end
end

function this:Unregister(listener)
    if listener.gameEvents ~= nil then
        ListenersUnregister(listener, listener.gameEvents, true)
    end
    
    if listener.customEvents ~= nil then
        ListenersUnregister(listener, listener.customEvents, false)
    end
end


-- Custom Events
function this:SendCustomEvent(eventName, ...)
    if Listeners[eventName] ~= nil then
        RelayEvent(eventName, ...)
    end
end