TheEyeAddon.Helpers.ChildArrangers = {}
local this = TheEyeAddon.Helpers.ChildArrangers


this.Delegate =
{
    Arrange = function(parentFrame, groupInstance, childUIObjects)
        for i = 1, #childUIObjects do
            local childUIObject = childUIObjects[i]
            local childFrame = childUIObject.Frame.instance
            local childPointSettings = childUIObject.Frame.DisplayData.DimensionTemplate.PointSettings
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
    Arrange = function(parentFrame, groupInstance, childUIObjects)
        local combinedOffsetY = 0

        for i = 1, #childUIObjects do
            local childFrame = childUIObjects[i].Frame.instance
            if childFrame ~= nil then
                childFrame:ClearAllPoints()
                childFrame:SetPoint(
                    "TOP",
                    parentFrame,
                    "TOP",
                    0,
                    combinedOffsetY
                )
                
                combinedOffsetY = combinedOffsetY - childFrame:GetHeight() - (groupInstance.childPadding or 0)
            end
        end
    end,
}