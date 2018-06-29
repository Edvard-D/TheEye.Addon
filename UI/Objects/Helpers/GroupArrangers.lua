local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.GroupArrangers = {}


TheEyeAddon.UI.Objects.GroupArrangers.TopToBottom =
{
    point = "TOP",
    relativePoint = "TOP",
    UpdateOffset = function(xOffset, yOffset, frame)
        return xOffset, yOffset - frame:GetHeight()
    end
}