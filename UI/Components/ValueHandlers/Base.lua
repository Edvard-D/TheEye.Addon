local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base

-- DEFINED IN TEMPLATE
--      Listeners           table { Listener }


-- SETUP
--      ChangeValue,        function(self.value)
--      valueDefault        value
function this:Setup(
    instance,
    ChangeValue,
    valueDefault
)
    instance.ChangeValue = ChangeValue
    instance.valueDefault = valueDefault
    instance.value = valueDefault
    
    instance.Reset = function()
        self.value = self.valueDefault
    end
end