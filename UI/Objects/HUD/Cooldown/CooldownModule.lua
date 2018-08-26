local parentKey = "GROUP_HUD_LEFT"

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "MODULE", "COOLDOWN" },
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
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObjectKey]] parentKey, --[[componentName]] "VisibleState" },
                    value = 4,
                },
            },
        },
    },
    Group =
    {
        childArranger = TheEyeAddon.Helpers.ChildArrangers.TopToBottom,
        sortActionName = "SortAscending",
        sortValueComponentName = "Cooldown",
    },
    PriorityRank =
    {
        ValueHandler =
        {
            validKeys = { [0] = 1, }
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