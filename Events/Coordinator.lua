local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = {}
local this = TheEyeAddon.Events.Coordinator
this.Listeners = {}
local Listeners = this.Listeners

local frame = CreateFrame("Frame", nil, UIParent)
local table = table


-- Event Handling
local function RelayEvent(self, eventName, ...)
    --print ("Coordinator RelayEvent    " .. eventName) -- DEBUG
    local listeners = Listeners[eventName]
    for i=1,#listeners do
        listeners[i]:Notify(eventName, ...)
    end
end
frame:SetScript("OnEvent", RelayEvent)


-- Subscribe/Unregister
local function InsertListener(eventName, listener, isGameEvent)
    if Listeners[eventName] == nil then
        Listeners[eventName] = { listener }
        --print ("RegisterEvent    " .. eventName) -- DEBUG

        if isGameEvent == true then
            frame:RegisterEvent(eventName)
        end
    else
        table.insert(Listeners[eventName], listener)
    end

    local eventGroup = Listeners[eventName]
    if eventGroup.listenerCount == nil then
        eventGroup.listenerCount = 0
    end
    eventGroup.listenerCount = eventGroup.listenerCount + 1
end

local function RemoveListener(eventName, listener, isGameEvent)
    local eventGroup = Listeners[eventName]
    table.removevalue(eventGroup, listener)
    
    eventGroup.listenerCount = eventGroup.listenerCount - 1
    if eventGroup.listenerCount == 0 then -- If the listenerCount was greater than 0 before
        Listeners[eventName] = nil
        eventGroup = nil
        --print ("UnregisterEvent    " .. eventName) -- DEBUG

        if isGameEvent == true then
            frame:UnregisterEvent(eventName)
        end
    end
end

local function RegisterListeners(events, listener, isGameEvent)
    for i=1,#events do
        InsertListener(events[i], listener, isGameEvent)
    end
end

local function UnregisterListeners(events, listener, isGameEvent)
    for i=1,#events do
        RemoveListener(events[i], listener, isGameEvent)
    end
end

function this:RegisterListener(listener)
    if listener.gameEvents ~= nil then
        RegisterListeners(listener.gameEvents, listener, true)
    end

    if listener.customEvents ~= nil then
        UnregisterListeners(listener.customEvents, listener, false)
    end
end

function this:UnregisterListener(listener)
    if listener.gameEvents ~= nil then
        UnsubscribeFromEvents(listener.gameEvents, listener, true)
    end
    
    if listener.customEvents ~= nil then
        UnsubscribeFromEvents(listener.customEvents, listener, false)
    end
end


-- Custom Events
function this:SendCustomEvent(eventName, ...)
    if Listeners[eventName] ~= nil then
        RelayEvent(frame, eventName, ...)
    end
end