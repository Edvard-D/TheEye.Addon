local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandlers.Base = {}
local this = TheEyeAddon.UI.Objects.Components.ValueHandlers.Base


function this:Create(
    setup, -- function
    changeValue, -- function
    valueDefault -- value
)
    
    local instance = {}
    
    instance.Reset = function()
        self.value = self.valueDefault
    end

    instance.Setup = setup
    instance.ChangeValue = changeValue
    
    instance.valueDefault = valueDefault
    instance.value = valueDefault

    return instance 
end