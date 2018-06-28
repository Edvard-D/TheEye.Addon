local TheEyeAddon = TheEyeAddon

local table = table


function TheEyeAddon.UI.Objects:RegisterChild(event, uiObject)
    if self.uiObject.Children == nil then
        self.uiObject.Children = { uiObject }
    else
        table.insert(self.uiObject.Children, uiObject)
    end
end