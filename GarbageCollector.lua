local TheEyeAddon = TheEyeAddon
TheEyeAddon.GarbageCollector = {}
local this = TheEyeAddon.GarbageCollector

local collectgarbage = collectgarbage
local shouldCollectGarbage = false


this.gameEvents =
{
    "PLAYER_REGEN_ENABLED",
}
-- @TODO Fire when a module is disabled in settings
this.customEvents =
{
    "UIOBJECT_MODULE_SETTING_CHANGED",
    "UPDATE",
}


function this:Initialize()
    TheEyeAddon.Events.Coordinator.Register(this)
end

function this:OnEvent(event)
    if event == "UPDATE" then
        if shouldCollectGarbage == true then
            collectgarbage()
            shouldCollectGarbage = false
        end
    else -- UIOBJECT_DISABLED
        shouldCollectGarbage = true
    end
end