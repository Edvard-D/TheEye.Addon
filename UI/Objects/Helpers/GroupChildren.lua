local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.GroupChildren = {}


function TheEyeAddon.UI.Objects.GroupChildren:ClearAll()
    local children = uiObject.children
    if children ~= nil then
        for i=#children, -1 do
            children[i] = nil
        end
    end
end