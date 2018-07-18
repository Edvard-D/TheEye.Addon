local spellID = 228260

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-228260", },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = spellID,
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
            defaultValue = 9,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [40] = true, [44] = true, [46] = true, [48] = true, [52] = true, [54] = true, [68] = true }
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_START_RECENTLY_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "PLAYER_TALENT_ACTIVE_CHANGED",
                    inputValues = { --[[tier]] 7, --[[column]] 1, },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "UNIT_POWER_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "player", --[[powerType]] "INSANITY", },
                    comparisonValues =
                    {
                        value = 0.9,
                        type = "GreaterThanEqualTo"
                    },
                    value = 16,
                },
                {
                    eventEvaluatorKey = "UNIT_POWER_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "player", --[[powerType]] "INSANITY", },
                    comparisonValues =
                    {
                        value = 0.6,
                        type = "GreaterThanEqualTo"
                    },
                    value = 32,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 194249, },
                    value = 64,
                },
            },
        },
    },
}
)