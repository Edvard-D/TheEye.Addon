local TheEyeAddon = TheEyeAddon


local function RegisterToEvents(eventHandler)
    for k,v in pairs(eventHandler.registerTo) do
        eventHandler.frame:RegisterEvent(eventHandler.registerTo[k])
    end
end