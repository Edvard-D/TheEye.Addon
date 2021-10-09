local parentKey = "UIPARENT"

TheEye.Core.Managers.UI.GrouperAdd(
{
    tags = { "HUD", },
    Child =
    {
        parentKey = parentKey,
    },
    ActionBarCombatHider = {},
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
        childArranger = TheEye.Core.Helpers.ChildArrangers.Horizontal,
        childPadding = 50,
        sortActionName = "SortAscending",
        sortValueComponentName = "PriorityRank",
        anchorChildSortValue = 2,
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys =
            {
                [6] = true, [14] = true, [30] = true, [38] = true, [46] = true, [54] = true,
                [60] = true, [62] = true,
            },
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
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] "_", },
                    value = 16,
                },
                {
                    eventEvaluatorKey = "UNIT_CAN_ATTACK_UNIT_CHANGED",
                    inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] "target", },
                    value = 32,
                },
                {
                    eventEvaluatorKey = "UNIT_IN_VEHICLE_CHANGED",
                    inputValues = { --[[unit]] "player", },
                    value = 64,
                },
            },
        },
    },
})