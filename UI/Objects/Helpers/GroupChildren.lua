local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.GroupChildren = {}


local function ClearAll(uiObject)
    local children = uiObject.children
    if children ~= nil then
        for i=#children, -1 do
            children[i] = nil
        end
    end
end

function TheEyeAddon.UI.Objects.GroupChildren:ChildrenUpdateRegistration(state, event, childUIObject)
    local uiObject = self.uiObject
    local children = uiObject.Children

    if event == "UIOBJECT_WITHTAGS_VISIBILE_CHANGED" then
        if children == nil then
            uiObject.Children = { childUIObject }
        else
            table.insert(children, childUIObject)
        end
    else -- UIOBJECT_VISIBILE_CHANGED
        ClearAll(uiObject)
    end
end

function TheEyeAddon.UI.Objects.GroupChildren:ChildrenSortDescending(state, event, childUIObject)
    table.sort(self.uiObject.Children, function(a,b)
        return a.ValueHandlers.SortRank.value > b.ValueHandlers.SortRank.value end)
end

function TheEyeAddon.UI.Objects.GroupChildren:ChildrenArrange()
    self.uiObject.frame:ChildrenArrange(self.uiObject.Children)
end