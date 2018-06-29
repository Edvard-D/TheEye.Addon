local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ValueHandlers = {}


function TheEyeAddon.UI.Objects.ValueHandlers:OnStateKeyChange(valueChange)
    self.value = self.value + valueChange

    if self.validValues[self.value] == true then
        self:OnValidValue(self.uiObject)
    else
        self:OnInvalidValue(self.uiObject)
    end
end