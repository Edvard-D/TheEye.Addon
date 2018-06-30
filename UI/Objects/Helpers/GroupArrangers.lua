local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.GroupArrangers = {}


TheEyeAddon.UI.Objects.GroupArrangers.TopToBottom =
{
    point = "TOP",
    relativePoint = "TOP",
    UpdateOffset = function(offsetX, offsetY, frame)
        return offsetX, offsetY - frame:GetHeight()
    end
}