local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.ChildArrangers = {}
local this = TheEyeAddon.UI.ChildArrangers


this.Delegate =
{
    Arrange = function(parentFrame, childUIObjects)
        for i = 1, #childUIObjects do
            local childFrame = childUIObjects[i].Frame
            local childPointSettings = childFrame.UIObject.DisplayData.DimensionTemplate.PointSettings
            childFrame:ClearAllPoints()
            childFrame:SetPoint(
                childPointSettings.point,
                parentFrame,
                childPointSettings.relativePoint,
                childPointSettings.offsetX or 0, childPointSettings.offsetY or 0)
        end
    end,
}

this.TopToBottom =
{
    Arrange = function(parentFrame, childUIObjects)
        local combinedOffsetX = 0
        local combinedOffsetY = 0

        for i = 1, #childUIObjects do
            local childFrame = childUIObjects[i].Frame
            if childFrame ~= nil then
                childFrame:ClearAllPoints()
                childFrame:SetPoint(
                    "TOP",
                    parentFrame,
                    "TOP",
                    combinedOffsetX, combinedOffsetY)
                
                combinedOffsetY = combinedOffsetY - childFrame:GetHeight()
            end
        end
    end,
}