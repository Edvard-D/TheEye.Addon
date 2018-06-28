local TheEyeAddon = TheEyeAddon


function TheEyeAddon.UI.Objects:OnStateChange(newState)
    local stateGroup = self.stateGroup
    
    if newState == true then
        stateGroup.combinedKeyValue = stateGroup.combinedKeyValue + self.keyValue
    else
        stateGroup.combinedKeyValue = stateGroup.combinedKeyValue - self.keyValue
    end

    if stateGroup.validKeys[stateGroup.combinedKeyValue] == true then
        stateGroup:OnValidKey(self.uiObject)
    else
        stateGroup:OnInvalidKey(self.uiObject)
    end
end

function TheEyeAddon.UI.Objects:Enable(uiObject)
    if uiObject.StateGroups.Enabled.currentState ~= true then
        print ("ENABLE    " .. uiObject.key) -- DEBUG
        uiObject.StateGroups.Enabled.currentState = true

        TheEyeAddon.UI.Objects:SetupStateGroup(uiObject, uiObject.StateGroups.Visible)
        TheEyeAddon.UI.Objects:SetupEventGroups(uiObject)

        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_ENABLED", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Disable(uiObject)
    if uiObject.StateGroups.Enabled.currentState ~= false then
        print ("DISABLE    " .. uiObject.key) -- DEBUG
        TheEyeAddon.UI.Objects:Hide(uiObject)

        TheEyeAddon.UI.Objects:TeardownGroup(uiObject.StateGroups.Visible)
        TheEyeAddon.UI.Objects:TeardownEventGroups(uiObject)

        uiObject.StateGroups.Enabled.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_DISABLED", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Show(uiObject)
    if uiObject.StateGroups.Visible.currentState ~= true then
        print ("SHOW    " .. uiObject.key) -- DEBUG
        uiObject.frame = uiObject.DisplayData.factory:Claim(uiObject.DisplayData)
        uiObject.StateGroups.Visible.currentState = true
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_SHOWN", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Hide(uiObject)
    if uiObject.StateGroups.Visible.currentState ~= false then
        print ("HIDE    " .. uiObject.key) -- DEBUG
        TheEyeAddon.UI.Pools:Release(uiObject.frame)
        uiObject.frame = nil
        uiObject.StateGroups.Visible.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_HIDDEN", uiObject)
    end
end