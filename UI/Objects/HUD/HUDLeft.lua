local parentKey = "GROUP_HUD"

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "HUD", "LEFT" },
    Child =
    {
        parentKey = parentKey,
    },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        DimensionTemplate =
        {
            PointSettings =
            {
                point = "TOPRIGHT",
                relativePoint = "TOP",
                offsetX = -32.5,
                offsetY = -5,
            },
        },
    },
    EnabledState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_VISIBLE_CHANGED",
                    inputValues = { --[[uiObjectKey]] parentKey },
                    value = 2,
                },
            },
        },
    },
    Parent =
    {
        ChildArranger = TheEyeAddon.UI.ChildArrangers.TopToBottom,
        sortActionName = "SortDescending",
        sortValueComponentName = "PriorityRank",
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [0] = true },
        },
    },
}
)