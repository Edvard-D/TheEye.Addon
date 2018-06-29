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

function TheEyeAddon.UI.Objects.ValueHandlers:Setup(uiObject)
    for k,valueHandler in pairs(uiObject.ValueHandlers) do
        uiObject.ValueHandlers[k].uiObject = uiObject

        if valueHandler.Setup ~= nil then
            valueHandler:Setup()
        end
    end
end

-- ChangeValue
function TheEyeAddon.UI.Objects.ValueHandlers:OnStateKeyChange(valueChange)
    self.value = self.value + valueChange

    if self.validValues[self.value] == true then
        self.state = true
        self:OnValidValue(self.uiObject)
    else
        self.state = false
        self:OnInvalidValue(self.uiObject)
    end
end

function TheEyeAddon.UI.Objects.ValueHandlers:OnPriorityChange(valueChange)
    self.value = self.value + valueChange
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_PRIORITY_CHANGED", uiObject)
end


-- OnValidValue
function TheEyeAddon.UI.Objects.ValueHandlers:Enable(uiObject)
    print ("ENABLE    " .. uiObject.key) -- DEBUG

    TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, uiObject.ListenerGroups.Visible)
    TheEyeAddon.UI.Objects.ListenerGroups:SetupGroupsOfType(uiObject, "EVENT")

    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_ENABLED", uiObject)
end