TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "HUD", "MODULE", "PRIMARY" },
    Children =
    {
        childTags = { --[[tags]] "HUD", "ICON", "PRIMARY" },
        GroupArranger = TheEyeAddon.UI.Objects.GroupArrangers.TopToBottom,
        sortActionName = "SortDescending",
        sortValueComponentName = "PriorityRank",
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
            },
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
                    eventEvaluatorKey = "Module_Enabled",
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY" }, -- @TODO have Setup auto populate fields with some special character, like "#thisKey"
                    value = 2,
                },
                {
                    eventEvaluatorKey = "Module_Enabled",
                    inputValues = { --[[uiObjectKey]] "GROUP_UIPARENT" },
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
                    eventEvaluatorKey = "Unit_CanAttack_Unit",
                    inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] "target" },
                    value = 2,
                },
            },
        },
    },
}
)