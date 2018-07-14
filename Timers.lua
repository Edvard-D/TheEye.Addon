local TheEyeAddon = TheEyeAddon
TheEyeAddon.Timers = {}
this = TheEyeAddon.Timers

local After = C_Timer.After
local SendCustomEvent = TheEyeAddon.Events.Coordinator.SendCustomEvent
local unpack = unpack


function this.StartEventTimer(duration, eventName, ...)
    local args = { duration, ... }
    After(duration, 
    function()
        SendCustomEvent(eventName, unpack(args))
    end)
end