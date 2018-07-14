local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.GroupArrangers = {}
local this = TheEyeAddon.UI.Objects.GroupArrangers


this.Delegate =
{
    SetPoint = function(parentFrame, childFrame, childPointSettings)
        childFrame:SetPoint(
            childPointSettings.point,
            parentFrame,
            childPointSettings.relativePoint,
            childPointSettings.offsetX or 0, childPointSettings.offsetY or 0)
    end,
    UpdateOffset = function()
        return 0, 0
    end
}

this.TopToBottom =
{
    SetPoint = function(parentFrame, childFrame, childPointSettings, offsetX, offsetY)
        childFrame:SetPoint(
            "TOP",
            parentFrame,
            "TOP",
            offsetX or 0, offsetY or 0)
    end,
    UpdateOffset = function(childFrame, offsetX, offsetY)
        return offsetX, offsetY - childFrame:GetHeight()
    end
}