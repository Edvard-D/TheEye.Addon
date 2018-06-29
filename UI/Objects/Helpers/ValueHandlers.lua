local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ValueHandlers = {}

local pairs = pairs


-- Setup
function TheEyeAddon.UI.Objects.ValueHandlers:SetupStateValue()
    self.value = 0
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

    if self.validValues[self.value] ~= self.state then
        self.state = self.validValues[self.value]

        if self.state == true then
            self:OnValidValue(self.uiObject)
        else
            self:OnInvalidValue(self.uiObject)
        end
    end
end

function TheEyeAddon.UI.Objects.ValueHandlers:OnPriorityChange(valueChange)
    self.value = self.value + valueChange
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_PRIORITY_CHANGED", uiObject)
end


-- OnValidValue
function TheEyeAddon.UI.Objects.ValueHandlers:Enable(uiObject)
    print ("ENABLE    " .. uiObject.key) -- DEBUG
    uiObject.ValueHandlers["Visible"]:ChangeValue(0)

    TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, uiObject.ListenerGroups.Visible)
    TheEyeAddon.UI.Objects.ListenerGroups:SetupGroupsOfType(uiObject, "EVENT")

    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_ENABLED", uiObject)
end

function TheEyeAddon.UI.Objects.ValueHandlers:Show(uiObject)
    print ("SHOW    " .. uiObject.key) -- DEBUG
    uiObject.frame = uiObject.DisplayData.factory:Claim(uiObject.DisplayData)
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_SHOWN", uiObject)
end


-- OnInvalidValue
function TheEyeAddon.UI.Objects.ValueHandlers:Disable(uiObject)
    print ("DISABLE    " .. uiObject.key) -- DEBUG
    uiObject.ValueHandlers["Visible"].state = nil

    TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroup(uiObject.ListenerGroups.Visible)
    TheEyeAddon.UI.Objects.ListenerGroups:TeardownGroupsOfType(uiObject, "EVENT")

    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_DISABLED", uiObject)
end

function TheEyeAddon.UI.Objects.ValueHandlers:Hide(uiObject)
    print ("HIDE    " .. uiObject.key) -- DEBUG
    TheEyeAddon.UI.Pools:Release(uiObject.frame)
    uiObject.frame = nil
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_HIDDEN", uiObject)
end