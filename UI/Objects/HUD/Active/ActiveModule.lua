local parentKey = "GROUP_HUD_LEFT"

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "MODULE", "ACTIVE" },
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
        childArranger = TheEyeAddon.UI.ChildArrangers.TopToBottom,
        sortActionName = "SortDescending",
        sortValueComponentName = "PriorityRank",
    },
    PriorityRank =
    {
        isDynamic = false,
        ValueHandler =
        {
            value = 2,
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