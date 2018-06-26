local TheEyeAddon = TheEyeAddon
TheEyeAddon.Timers = {}

local After = C_Timer.After
local unpack = unpack


function TheEyeAddon.Timers:StartEventTimer(duration, eventName, ...)
    local args = { duration, ... }
    After(duration, 
    function()
        TheEyeAddon.Events.Coordinator:SendCustomEvent(eventName, unpack(args))
    end)
end