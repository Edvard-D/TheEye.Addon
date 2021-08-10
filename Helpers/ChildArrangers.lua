TheEye.Core.Helpers.ChildArrangers = {}
local this = TheEye.Core.Helpers.ChildArrangers


this.Delegate =
{
    Arrange = function(parentFrame, groupInstance, childUIObjects)
        for i = 1, #childUIObjects do
            local childUIObject = childUIObjects[i]
            local childFrame = childUIObject.Frame.instance
            if groupInstance.maxDisplayedChildren == nil or i <= groupInstance.maxDisplayedChildren then
                local childPointSettings = childUIObject.Frame.Dimensions.PointSettings
                childFrame:Show()
                childFrame:ClearAllPoints()
                childFrame:SetPoint(
                    childPointSettings.point,
                    parentFrame,
                    childPointSettings.relativePoint,
                    childPointSettings.offsetX or 0,
                    childPointSettings.offsetY or 0
                )
            else
                childFrame:Hide()
            end
        end
    end,
}

this.Horizontal =
{
    Arrange = function(parentFrame, groupInstance, childUIObjects)
        local combinedOffsetX = 0
    
        for i = 1, #childUIObjects do
            local childFrame = childUIObjects[i].Frame.instance
            if childFrame ~= nil then
                if groupInstance.maxDisplayedChildren == nil or i <= groupInstance.maxDisplayedChildren then
                    childFrame:Show()
                    childFrame:ClearAllPoints()
                    childFrame:SetPoint(
                        "TOPLEFT",
                        parentFrame,
                        "TOPLEFT",
                        combinedOffsetX,
                        0
                    )
                    
                    combinedOffsetX = combinedOffsetX + childFrame:GetWidth() + (groupInstance.childPadding or 0)
                else
                    childFrame:Hide()
                end
            end
        end
    end,
}

this.Vertical =
{
    Arrange = function(parentFrame, groupInstance, childUIObjects)
        local combinedOffsetY = 0

        for i = 1, #childUIObjects do
            local childFrame = childUIObjects[i].Frame.instance
            if childFrame ~= nil then
                if groupInstance.maxDisplayedChildren == nil or i <= groupInstance.maxDisplayedChildren then
                    childFrame:Show()
                    childFrame:ClearAllPoints()
                    childFrame:SetPoint(
                        "TOP",
                        parentFrame,
                        "TOP",
                        0,
                        combinedOffsetY
                    )
                    
                    combinedOffsetY = combinedOffsetY - childFrame:GetHeight() - (groupInstance.childPadding or 0)
                else
                    childFrame:Hide()
                end
            end
        end
    end,
}