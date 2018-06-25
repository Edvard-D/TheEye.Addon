TheEyeAddon.UI.Objects:Add(
{
    tags = { "HUD", "MODULE", "PRIMARY" },
    sortType = nil, --TheEyeAddon.UI.SortType.prioritySort,
    OnComponentVisibleChanged = function() end, --TODO
    DisplayData =
    {
        dimensionTemplate =
        {
            width = 0,
            height = 0,
            point = "TOP",
            relativePoint = "CENTER",
            offsetX = 0,
            offsetY = -50,
        },
    },    
    Components = { }
}
)