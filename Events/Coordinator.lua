local TheEyeAddon = TheEyeAddon
TheEyeAddon.Events.Coordinator = { Handlers = {} }
local Handlers = TheEyeAddon.Events.Coordinator.Handlers


local frame = CreateFrame("Frame", nil, UIParent)
local function HandleEvent(self, eventName)
    for i,handler in ipairs(Handlers.eventName) do
        TheEyeAddon.Events.Handlers:EvaluateState(handler, eventName)
    end
end
frame:SetScript("OnEvent", HandleEvent)


function TheEyeAddon.Events.Coordinator:RegisterHandler(handler)
    for i,eventName in ipairs(handler.registerTo) do
        if Handlers.eventName == nil then
            Handlers.eventName = { handler }
            frame:RegisterEvent(eventName)
        else
            table.insert(Handlers.eventName, handler)
        end

        if Handlers.eventName.handlerCount == nil then
            Handlers.eventName.handlerCount = 0
        end
        Handlers.eventName.handlerCount = Handlers.eventName.handlerCount + 1
    end
end

function TheEyeAddon.Events.Coordinator:UnregisterHandler(handler)
    for i,eventName in ipairs(handler.registerTo) do
        table.removevalue(Handlers.eventName, handler)
        
        Handlers.eventName.handlerCount = Handlers.eventName.handlerCount - 1
        if Handlers.eventName.handlerCount == 0 then
            frame:UnregisterEvent(eventName)
        elseif Handlers.eventName.handlerCount < 0 then
            error("Registered handlers set to " ..
                tostring(Handlers.eventName.handlerCount) ..
                " but should never be below 0.")
        end
    end
end