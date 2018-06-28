local TheEyeAddon = TheEyeAddon


function TheEyeAddon.UI.Objects:OnPriorityChange(newState)
    local listenerGroup = self.listenerGroup
    
    if newState == true then
        listenerGroup.combinedKeyValue = listenerGroup.combinedKeyValue + self.keyValue
    else
        listenerGroup.combinedKeyValue = listenerGroup.combinedKeyValue - self.keyValue
    end

    TheEyeAddon.Events.Coordinator:SendCustomEvent("UIOBJECT_PRIORITY_CHANGED", uiObject)
end