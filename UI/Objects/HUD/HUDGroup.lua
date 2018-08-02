local parentKey = "UIPARENT"

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "HUD", },
    Child =
    {
        parentKey = parentKey,
    },
    EnabledState =
    {
        ValueHandler =
        {
            validKeys = { [6] = true },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_MODULE_SETTING_CHANGED",
                    inputValues = { --[[uiObjectKey]] "#SELF#UIOBJECT#KEY#" },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UIOBJECT_VISIBLE_CHANGED",
                    inputValues = { --[[uiObjectKey]] parentKey },
                    value = 4,
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
                    point = "TOP",
                    relativePoint = "CENTER",
                    offsetY = -75,
                }
            },
        },
        childArranger = TheEyeAddon.UI.ChildArrangers.Delegate,
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [6] = true },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_CAN_ATTACK_UNIT_CHANGED",
                    inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] "target" },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "target" },
                    comparisonValues =
                    {
                        value = 0,
                        type = "GreaterThan"
                    },
                    value = 4,
                },
            },
        },
    },
}
)