local parentKey = "GROUP_HUD"

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "MODULE", "PRIMARY" },
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
                    inputValues = { --[[uiObjectKey]] "HUD_MODULE_PRIMARY" }, -- @TODO have Setup auto populate fields with some special character, like "#thisKey"
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
                    relativePoint = "TOP",
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