local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base


function this:Setup(
    instance,
    -- this
    ChangeValue,    -- function(value)
    valueDefault    -- value
)
    instance.ChangeValue = ChangeValue
    instance.valueDefault = valueDefault
    instance.value = valueDefault
    
    instance.Reset = function()
        self.value = self.valueDefault
    end

    return instance 
end