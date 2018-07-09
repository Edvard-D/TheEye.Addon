TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-15407", },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = 15407,
        fontTemplate = TheEyeAddon.UI.Fonts.Templates.Icon.default,
    },
    EnabledState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIObject_Visible",
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY", },
                    value = 2,
                },
            },
        },
    },
    PriorityRank =
    {
        isDynamic = false,
        defaultValue = 1,
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [0] = true, [4] = true, [6] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "Unit_Spellcast_Active",
                    inputValues = { --[[unit]] "player", --[[spellID]] 15407, },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "Unit_Spellcast_CastRecently",
                    inputValues = { --[[unit]] "player", --[[spellID]] 15407, },
                    value = 4,
                },
            },
        },
    },
}
)