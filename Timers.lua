local TheEyeAddon = TheEyeAddon
TheEyeAddon.Timers = {}
local this = TheEyeAddon.Timers

local After = C_Timer.After
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent
local unpack = unpack


function this.StartEventTimer(duration, eventName, ...)
    local args = { duration, ... } -- @TODO remove duration
    After(duration, 
    function()
        SendCustomEvent(eventName, unpack(args))
    end)
end

local function NewCooldownTimerGetLength(inputGroup, remainingTime)
    local nextUpdatePoint = 0
    local listeners = inputGroup.listeners
    for i=1, #listeners do
        listener = listeners[i]
        if listener.comparisonValues ~= nil then
            local value = listener.comparisonValues.value
            if value > nextUpdatePoint and value <= remainingTime then
                nextUpdatePoint = value
            end
        end
    end

    return remainingTime - nextUpdatePoint
end

function this.InputGroupCooldownTimerStart(inputGroup, remainingTime, eventName, ...)
    if remainingTime ~= 0 then
        this.StartEventTimer(NewCooldownTimerGetLength(inputGroup, remainingTime), eventName, ...)
    end
end