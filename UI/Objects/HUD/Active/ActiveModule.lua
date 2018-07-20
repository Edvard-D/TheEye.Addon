TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "MODULE", "ACTIVE" },
    Children =
    {
        childTags = { --[[tags]] "HUD", "ICON", "ACTIVE" },
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
                point = "TOPLEFT",
                relativePoint = "LEFT",
                offsetX = -20,
                offsetY = -5,
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
                    eventEvaluatorKey = "UIOBJECT_MODULE_ENABLED_CHANGED",
                    inputValues = { --[[uiObjectKey]] "HUD_MODULE_ACTIVE" }, -- @TODO have Setup auto populate fields with some special character, like "#thisKey"
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UIOBJECT_VISIBLE_CHANGED",
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD" },
                    value = 4,
                },
            },
        },
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