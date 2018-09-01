local parentKey = "GROUP_HUD"

TheEyeAddon.Managers.UI:FormatData(
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
    Frame =
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
    },
    Group =
    {
        childArranger = TheEyeAddon.Helpers.ChildArrangers.TopToBottom,
        childPadding = 5,
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