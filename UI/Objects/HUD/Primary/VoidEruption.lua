local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 228260

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-228260", },
    Child =
    {
        key = parentKey,
    },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon.Large,
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
                    inputValues = { --[[uiObjectKey]] parentKey, },
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
            defaultValue = 10,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys =
            {
                [20] = true, [22] = true, [24] = true, [28] = true, [30] = true, [68] = true,
                [70] = true, [80] = true, [84] = true, [86] = true, [88] = true, [92] = true,
                [94] = true, [116] = true, [124] = true,
            }
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
                    eventEvaluatorKey = "UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = TheEyeAddon.Values.castStartHideDelay,
                        type = "LessThan"
                    },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_POWER_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "player", --[[powerType]] "INSANITY", },
                    comparisonValues =
                    {
                        value = 0.9,
                        type = "GreaterThanEqualTo"
                    },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "UNIT_POWER_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "player", --[[powerType]] "INSANITY", },
                    comparisonValues =
                    {
                        value = 0.6,
                        type = "GreaterThanEqualTo"
                    },
                    value = 16,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 194249, },
                    value = 32,
                },
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] 21637, },
                    value = 64,
                },
            },
        },
    },
}
)