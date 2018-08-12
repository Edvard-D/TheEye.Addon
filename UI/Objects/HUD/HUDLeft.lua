local parentKey = "GROUP_HUD"

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "HUD", "LEFT" },
    Child =
    {
        parentKey = parentKey,
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
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObjectKey]] parentKey, --[[componentName]] "VisibleState" },
                    value = 2,
                },
            },
        },
    },
    Group =
    {
        DisplayData =
        {
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
        childArranger = TheEyeAddon.UI.ChildArrangers.TopToBottom,
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