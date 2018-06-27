local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = { Listeners = {} }
local Listeners = TheEyeAddon.Events.Coordinator.Listeners

local ipairs = ipairs
local table = table


local frame = CreateFrame("Frame", nil, UIParent)
local function OnEvent(self, eventName, ...)
    print ("Coordinator OnEvent    " .. eventName) -- DEBUG
    for i,listener in ipairs(Listeners[eventName]) do
        listener:OnEvent(eventName, ...)
    end
end
frame:SetScript("OnEvent", OnEvent)

local function InsertListener(eventName, listener, isGameEvent)
    if Listeners[eventName] == nil then
        Listeners[eventName] = { listener }
        print ("RegisterEvent    " .. eventName) -- DEBUG

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
        print ("UnregisterEvent    " .. eventName) -- DEBUG

        if isGameEvent == true then
            frame:UnregisterEvent(eventName)
        end
    end
end


function TheEyeAddon.Events.Coordinator:RegisterListener(listener)
    if listener.gameEvents ~= nil then
        for i,eventName in ipairs(listener.gameEvents) do
            InsertListener(eventName, listener, true)
        end
    end

    if listener.customEvents ~= nil then
        for i,eventName in ipairs(listener.customEvents) do
            InsertListener(eventName, listener, false)
        end
    end
end

function TheEyeAddon.Events.Coordinator:UnregisterListener(listener)
    if listener.gameEvents ~= nil then
        for i,eventName in ipairs(listener.gameEvents) do
            RemoveListener(eventName, listener, true)
        end
    end
    
    if listener.customEvents ~= nil then
        for i,eventName in ipairs(listener.customEvents) do
            RemoveListener(eventName, listener, false)
        end
    end
end

function TheEyeAddon.Events.Coordinator:SendCustomEvent(eventName, ...)
    if Listeners[eventName] ~= nil then
        HandleEvent(frame, eventName, ...)
    end
end