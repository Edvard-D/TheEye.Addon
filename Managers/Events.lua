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

local function OnDBMEvent(eventName, ...)
    RelayEvent(nil, eventName, ...)
end


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
local function ListenerRegister(listener, eventName, eventType)
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
    if listeners.listenerCount == 1 then
        DebugLogEntryAdd("TheEyeAddon.Managers.Events", "RegisterEvent", nil, nil, eventName)
        
        if eventType == "GAME" then
            frame:RegisterEvent(eventName)
        elseif eventType == "DBM" and DBM ~= nil then
            DBM:RegisterCallback(eventName, OnDBMEvent)
        end
    end
end

local function ListenersRegister(listener, events, eventType)
    for i = 1, #events do
        ListenerRegister(listener, events[i], eventType)
    end
end

function this.Register(listener)
    if listener.gameEvents ~= nil then
        ListenersRegister(listener, listener.gameEvents, "GAME")
    end

    if listener.customEvents ~= nil then
        ListenersRegister(listener, listener.customEvents, "CUSTOM")
    end

    if listener.dbmEvents ~= nil then
        ListenersRegister(listener, listener.dbmEvents, "DBM")
    end

    listener.isListening = true
end


-- Deregister
local function ListenerDeregister(listener, eventName, eventType)
    local listeners = Listeners[eventName]

    listeners.listenerCount = listeners.listenerCount - 1
    if listeners.listenerCount == 0 then
        DebugLogEntryAdd("TheEyeAddon.Managers.Events", "UnregisterEvent", nil, nil, eventName)

        if eventType == "GAME" then
            frame:UnregisterEvent(eventName)
        elseif eventType == "DBM" and DBM ~= nil then
            DBM:UnregisterCallback(eventName, OnDBMEvent)
        end
    end
end

local function ListenersDeregister(listener, events, eventType)
    for i = 1, #events do
        ListenerDeregister(listener, events[i], eventType)
    end
end

function this.Deregister(listener)
    if listener.gameEvents ~= nil then
        ListenersDeregister(listener, listener.gameEvents, "GAME")
    end
    
    if listener.customEvents ~= nil then
        ListenersDeregister(listener, listener.customEvents, "CUSTOM")
    end

    if listener.dbmEvents ~= nil then
        ListenersDeregister(listener, listener.dbmEvents, "DBM")
    end
    
    listener.isListening = false
end


-- Custom Events
function this.SendCustomEvent(eventName, ...)
    if Listeners[eventName] ~= nil then
        RelayEvent(nil, eventName, ...)
    end
end