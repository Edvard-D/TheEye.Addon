local TheEyeAddon = TheEyeAddon


function TheEyeAddon.UI.Objects:OnStateChange(newState)
    local listenerGroup = self.listenerGroup
    
    if newState == true then
        listenerGroup.combinedKeyValue = listenerGroup.combinedKeyValue + self.keyValue
    else
        listenerGroup.combinedKeyValue = listenerGroup.combinedKeyValue - self.keyValue
    end

    if listenerGroup.validKeys[listenerGroup.combinedKeyValue] == true then
        listenerGroup:OnValidKey(self.uiObject)
    else
        listenerGroup:OnInvalidKey(self.uiObject)
    end
end

function TheEyeAddon.UI.Objects:Enable(uiObject)
    if uiObject.ListenerGroups.Enabled.currentState ~= true then
        print ("ENABLE    " .. uiObject.key) -- DEBUG
        uiObject.ListenerGroups.Enabled.currentState = true

        TheEyeAddon.UI.Objects:SetupStateGroup(uiObject, uiObject.ListenerGroups.Visible)
        TheEyeAddon.UI.Objects:SetupListenerGroupsOfType(uiObject, "EVENT")

        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_ENABLED", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Disable(uiObject)
    if uiObject.ListenerGroups.Enabled.currentState ~= false then
        print ("DISABLE    " .. uiObject.key) -- DEBUG
        TheEyeAddon.UI.Objects:Hide(uiObject)

        TheEyeAddon.UI.Objects:TeardownGroup(uiObject.ListenerGroups.Visible)
        TheEyeAddon.UI.Objects:TeardownListenerGroupsOfType(uiObject, "EVENT")

        uiObject.ListenerGroups.Enabled.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_DISABLED", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Show(uiObject)
    if uiObject.ListenerGroups.Visible.currentState ~= true then
        print ("SHOW    " .. uiObject.key) -- DEBUG
        uiObject.frame = uiObject.DisplayData.factory:Claim(uiObject.DisplayData)
        uiObject.ListenerGroups.Visible.currentState = true
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_SHOWN", uiObject)
    end
end

function TheEyeAddon.UI.Objects:Hide(uiObject)
    if uiObject.ListenerGroups.Visible.currentState ~= false then
        print ("HIDE    " .. uiObject.key) -- DEBUG
        TheEyeAddon.UI.Pools:Release(uiObject.frame)
        uiObject.frame = nil
        uiObject.ListenerGroups.Visible.currentState = false
        TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_HIDDEN", uiObject)
    end
end