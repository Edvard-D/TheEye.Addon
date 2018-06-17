local TheEyeAddon = TheEyeAddon


TheEyeAddon.UI.Modules.Instances.Primary =
{
    tags = { "PRIMARY" },
    sortType = nil, --TheEyeAddon.UI.SortType.prioritySort,
    OnComponentVisibleChanged = function() end, --TODO
    dimensionTemplate =
    {
        width = 0,
        height = 0,
        point = "TOP",
        relativePoint = "CENTER",
        offsetX = 0,
        offsetY = -50,
    },
    Components = { }
}