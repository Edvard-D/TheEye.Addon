TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "UIPARENT" },
    Children =
    {
        childTags = { --[[tags]] "MODULE", },
    },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        DimensionTemplate =
        {
            PointSettings =
            {
                point = "CENTER",
                relativePoint = "CENTER",
                offsetY = -100,
            }
        }
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
                    eventEvaluatorKey = "Addon_Loaded",
                    inputValues = { --[[addonName]] "TheEyeAddon" },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "Game_Data_Loaded",
                    inputValues = nil,
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
                    eventEvaluatorKey = "Unit_Spec",
                    inputValues = { --[[unit]] "player", --[[specID]] 258 },
                    value = 2,
                },
            },
        },
    },
}
)