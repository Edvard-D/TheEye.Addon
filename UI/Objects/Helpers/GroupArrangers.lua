local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.GroupArrangers = {}
local this = TheEyeAddon.UI.Objects.GroupArrangers


this.Overlay =
{
    point = "CENTER",
    relativePoint = "CENTER",
    UpdateOffset = function(offsetX, offsetY)
        return 0, 0
    end
}

this.TopToBottom =
{
    point = "TOP",
    relativePoint = "TOP",
    UpdateOffset = function(offsetX, offsetY, frame)
        return offsetX, offsetY - frame:GetHeight()
    end
}