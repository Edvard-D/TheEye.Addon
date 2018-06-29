local TheEyeAddon = TheEyeAddon

local table = table


function TheEyeAddon.UI.Objects:RegisterChild(event, uiObject)
    if self.uiObject.Children == nil then
        self.uiObject.Children = { uiObject }
    else
        table.insert(self.uiObject.Children, uiObject)
    end
end

function TheEyeAddon.UI.Objects:SortChildrenByPriority(state, event, uiObject)
    table.sort(uiObject.Children, function(a,b)
        return a.ListenerGroups.Priority.combinedKeyValue > b.ListenerGroups.Priority.combinedKeyValue end) 
end