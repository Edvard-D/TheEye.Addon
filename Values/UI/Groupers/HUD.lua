local parentKey = "UIPARENT"

TheEyeAddon.Managers.UI.GrouperAdd(
{
    tags = { "HUD", },
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
        Dimensions =
        {
            PointSettings =
            {
                point = "TOP",
                relativePoint = "CENTER",
                offsetY = -75,
            },
        },
    },
    Group =
    {
        childArranger = TheEyeAddon.Helpers.ChildArrangers.Vertical,
        sortActionName = "SortAscending",
        sortValueComponentName = "PriorityRank",
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [14] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_AFFECTING_COMBAT_CHANGED",
                    inputValues = { --[[unit]] "player" },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "player" },
                    comparisonValues =
                    {
                        value = 0,
                        type = "GreaterThan"
                    },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "target" },
                    comparisonValues =
                    {
                        value = 0,
                        type = "GreaterThan"
                    },
                    value = 8,
                },
            },
        },
    },
})