TheEyeAddon.UI.ChildArrangers = {}
local this = TheEyeAddon.UI.ChildArrangers


this.Delegate =
{
    Arrange = function(parentFrame, childUIObjects)
        for i = 1, #childUIObjects do
            local childFrame = childUIObjects[i].frame
            local childPointSettings = childFrame.UIObject.DisplayData.DimensionTemplate.PointSettings
            childFrame:ClearAllPoints()
            childFrame:SetPoint(
                childPointSettings.point,
                parentFrame,
                childPointSettings.relativePoint,
                childPointSettings.offsetX or 0,
                childPointSettings.offsetY or 0
            )
        end
    end,
}

this.TopToBottom =
{
    Arrange = function(parentFrame, childUIObjects)
        local combinedOffsetY = 0

        for i = 1, #childUIObjects do
            local childFrame = childUIObjects[i].frame
            if childFrame ~= nil then
                childFrame:ClearAllPoints()
                childFrame:SetPoint(
                    "TOP",
                    parentFrame,
                    "TOP",
                    0,
                    combinedOffsetY
                )
                
                combinedOffsetY = combinedOffsetY - childFrame:GetHeight()
            end
        end
    end,
}