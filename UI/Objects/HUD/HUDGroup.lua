TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "HUD", },
    Children =
    {
        childTags = { --[[tags]] "HUD", "MODULE", },
        GroupArranger = TheEyeAddon.UI.Objects.GroupArrangers.Delegate,
    },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        DimensionTemplate =
        {
            PointSettings =
            {
                point = "TOP",
                relativePoint = "CENTER",
                offsetY = -50,
            }
        },
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
                    eventEvaluatorKey = "UIOBJECT_MODULE_ENABLED_CHANGED",
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD" }, -- @TODO have Setup auto populate fields with some special character, like "#thisKey"
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UIOBJECT_VISIBLE_CHANGED",
                    inputValues = { --[[uiObjectKey]] "UIPARENT" },
                    value = 4,
                },
            },
        },
    },
    VisibleState =
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
                    eventEvaluatorKey = "UNIT_CAN_ATTACK_UNIT_CHANGED",
                    inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] "target" },
                    value = 2,
                },
            },
        },
    },
}
)