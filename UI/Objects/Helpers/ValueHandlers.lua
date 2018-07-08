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