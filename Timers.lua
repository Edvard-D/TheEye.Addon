local TheEyeAddon = TheEyeAddon
TheEyeAddon.Timers = {}

local After = C_Timer.After


function TheEyeAddon.Timers:StartEventTimer(duration, eventName, ...)
    After(duration, 
    function(...)
        TheEyeAddon.Events.Coordinator:SendCustomEvent(eventName, ...)
    end)
end