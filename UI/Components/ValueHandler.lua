local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Components.ValueHandler = {}


function TheEyeAddon.UI.Components.ValueHandler:Create(setup, changeValue, valueDefault)
    local instance = {}
    
    -- Base
    instance.Reset = function() self.value = self.valueDefault end

    -- Passed
    instance.Setup = setup -- function
    instance.ChangeValue = changeValue -- function
    
    instance.valueDefault = valueDefault -- value
    instance.value = valueDefault -- value

    return instance 
end