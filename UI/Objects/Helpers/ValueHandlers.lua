local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ValueHandlers = {}


-- Setup
function TheEyeAddon.UI.Objects.ValueHandlers:SetupStateValue()
    self.value = 0
    self.state = false

    if self.validValues[0] == true then
        self.OnValidValue(self.uiObject)
    end
end


-- ChangeValue
function TheEyeAddon.UI.Objects.ValueHandlers:OnStateKeyChange(valueChange)
    self.value = self.value + valueChange

    if self.validValues[self.value] == true then
        self:OnValidValue(self.uiObject)
    else
        self:OnInvalidValue(self.uiObject)
    end
end