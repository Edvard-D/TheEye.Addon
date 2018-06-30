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

function TheEyeAddon.UI.Objects.GroupChildren:ChildrenUpdateRegistration(state, event, ...)
    local uiObject = self.UIObject
    local children = uiObject.Children

    if event == "UIOBJECT_WITHTAGS_VISIBILE_CHANGED" then
        if children == nil then
            local childUIObject = ...
            uiObject.Children = { childUIObject }
        else
            table.insert(children, childUIObject)
        end
    elseif ... == false then -- this UIObject_Visible
        ClearAll(uiObject)
    end
end

function TheEyeAddon.UI.Objects.GroupChildren:ChildrenSortDescending(state, event, childUIObject)
    table.sort(self.UIObject.Children, function(a,b)
        return a.ValueHandlers.SortRank.value > b.ValueHandlers.SortRank.value end)
end

function TheEyeAddon.UI.Objects.GroupChildren:ChildrenArrange()
    self.UIObject.frame:ChildrenArrange(self.UIObject.Children)
end