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