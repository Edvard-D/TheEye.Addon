local parentKey = "GROUP_HUD_LEFT"

TheEyeAddon.UI.Objects:FormatData(
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
                    inputValues = { --[[uiObjectKey]] "HUD_MODULE_COOLDOWN" }, -- @TODO have Setup auto populate fields with some special character, like "#thisKey"
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
        sortActionName = "SortAscending",
        sortValueComponentName = "Cooldown", -- @TOOD
    },
    PriorityRank =
    {
        isDynamic = false,
        ValueHandler =
        {
            value = 1,
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