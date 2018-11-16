TheEyeAddon.Managers.UI.FormatData(
{
    tags = { "UIPARENT" },
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
                    eventEvaluatorKey = "ADDON_LOADED",
                    inputValues = { --[[addonName]] "TheEyeAddon" },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "GAMEDATA_LOADED_CHANGED",
                    inputValues = nil,
                    value = 4,
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
                point = "CENTER",
                relativePoint = "CENTER",
                offsetY = -200,
            },
        },
    },
    Group =
    {
        childArranger = TheEyeAddon.Helpers.ChildArrangers.Delegate,
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
                    eventEvaluatorKey = "UNIT_SPEC_CHANGED",
                    inputValues = { --[[unit]] "player", --[[specID]] 258 },
                    value = 2,
                },
            },
        },
    },
}
)