local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ListenerGroup.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ListenerGroup.Base


function this:Setup(
    instance,
    -- temp
    ListenerSetup,  -- function( { Listener } )
    -- this
    Listeners,      -- table { Listener }
    OnSetup,        -- function(...)
    OnTeardown      -- function(...)
)

    instance.Listeners = Listeners
    for i=1, #Listeners do
        ListenerSetup(Listeners[i])
    end

    instance.OnSetup = OnSetup
    instance.OnTeardown = OnTeardown
end