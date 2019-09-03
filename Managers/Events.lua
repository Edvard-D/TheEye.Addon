TheEyeAddon.Managers.Events = {}
local this = TheEyeAddon.Managers.Events
local Listeners = {}

local DebugLogEntryAdd = TheEyeAddon.Managers.Debug.LogEntryAdd
local frame = CreateFrame("Frame", nil, UIParent)
local table = table
local updateInterval = 0.01


-- OnEvent
local function RelayEvent(self, eventName, ...)
    DebugLogEntryAdd("TheEyeAddon.Managers.Events", "RelayEvent", nil, nil, eventName)
    local listeners = Listeners[eventName]
    for i = 1, #listeners do
        -- Nil is checked since it's possible for a listener earlier in the array to
        -- cause a listener later in the array to be deregistered before its OnEvent
        -- function is called.
        local listener = listeners[i]
        
        if listener ~= nil and listener.isListening == true then
            listener:OnEvent(eventName, ...)
        end
    end
end
frame:SetScript("OnEvent", RelayEvent)


-- OnUpdate
local function RelayUpdate(self, elapsedTime)
    self.timeSinceUpdate = self.timeSinceUpdate + elapsedTime
    if self.timeSinceUpdate >= updateInterval then
        this.SendCustomEvent("UPDATE")
        self.timeSinceUpdate = 0
    end
end
frame:SetScript("OnUpdate", RelayUpdate)
frame.timeSinceUpdate = 0


-- Register
local function ListenerRegister(listener, eventName, isGameEvent)
    if Listeners[eventName] == nil then
        Listeners[eventName] = {}
    end

    local listeners = Listeners[eventName]
    if listener.isListening == nil then
        table.insert(listeners, listener)
    end

    if listeners.listenerCount == nil then
        listeners.listenerCount = 0
    end
    
    listeners.listenerCount = listeners.listenerCount + 1
    if listeners.listenerCount == 1 and isGameEvent == true then
        DebugLogEntryAdd("TheEyeAddon.Managers.Events", "RegisterEvent", nil, nil, eventName)
        frame:RegisterEvent(eventName)
    end
end

local function ListenersRegister(listener, events, isGameEvent)
    for i = 1, #events do
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

    listener.isListening = true
end


-- Deregister
local function ListenerDeregister(listener, eventName, isGameEvent)
    local listeners = Listeners[eventName]

    listeners.listenerCount = listeners.listenerCount - 1
    if listeners.listenerCount == 0 and isGameEvent == true then
        DebugLogEntryAdd("TheEyeAddon.Managers.Events", "UnregisterEvent", nil, nil, eventName)
        frame:UnregisterEvent(eventName)
    end
end

local function ListenersDeregister(listener, events, isGameEvent)
    for i = 1, #events do
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
    
    listener.isListening = false
end


-- Custom Events
function this.SendCustomEvent(eventName, ...)
    if Listeners[eventName] ~= nil then
        RelayEvent(nil, eventName, ...)
    end
end