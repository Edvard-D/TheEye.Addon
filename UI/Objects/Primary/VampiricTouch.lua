local spellID = 34914

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-34914" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = spellID,
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
                    eventEvaluatorKey = "UIOBJECT_VISIBLE_CHANGED",
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY", },
                    value = 2,
                },
            },
        },
    },
    PriorityRank =
    {
        isDynamic = false,
        ValueHandler =
        {
            defaultValue = 2,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [0] = true, [2] = true, [6] = true, [10] = true, [14] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_START_RECENTLY_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] spellID, },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 8,
                },
            },
        },
    },
}
)