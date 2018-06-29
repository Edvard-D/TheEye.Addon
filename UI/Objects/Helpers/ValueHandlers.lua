local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ValueHandlers = {}


function TheEyeAddon.UI.Objects:OnStateKeyChange(valueChange)
    self.value = self.value + valueChange

    if self.validValues[self.value] == true then
        self:OnValidValue(self.uiObject)
    else
        self:OnInvalidValue(self.uiObject)
    end
end