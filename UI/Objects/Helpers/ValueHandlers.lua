local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.ValueHandlers = {}

local pairs = pairs


-- Setup
function TheEyeAddon.UI.Objects.ValueHandlers:Setup(uiObject)
    for k,valueHandler in pairs(uiObject.ValueHandlers) do
        uiObject.ValueHandlers[k].UIObject = uiObject
        
        if valueHandler.Setup ~= nil then
            valueHandler:Setup()
        end
    end
end

-- ChangeValue
function TheEyeAddon.UI.Objects.ValueHandlers:OnSortRankChanged(valueChange)
    if valueChange ~= nil then
        self.value = self.value + valueChange
    end

    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_SORTRANK_CHANGED", uiObject)
end


-- OnValidValue
function TheEyeAddon.UI.Objects.ValueHandlers:Enable(uiObject)
    print ("ENABLE    " .. uiObject.key) -- DEBUG
    TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, uiObject.ListenerGroups.Visible)
    TheEyeAddon.UI.Objects.ListenerGroups:SetupGroupsOfType(uiObject, "EVENT")
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_ENABLED", uiObject)
end

function TheEyeAddon.UI.Objects.ValueHandlers:Show(uiObject)
    print ("SHOW    " .. uiObject.key) -- DEBUG
    uiObject.frame = uiObject.DisplayData.factory:Claim(uiObject, uiObject.DisplayData)
    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_SHOWN", uiObject)
end


-- OnInvalidValue
function TheEyeAddon.UI.Objects.ValueHandlers:Disable(uiObject)
    print ("DISABLE    " .. uiObject.key) -- DEBUG
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