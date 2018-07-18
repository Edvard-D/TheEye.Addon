local spellID = 200174

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-200174", },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = spellID,
    },
    -- @TODO cooldown
    EnabledState =
    {
        ValueHandler =
        {
            validKeys = { [6] = true, },
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
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] 21719, },
                    value = 4,
                },
            },
        },
    },
    PriorityRank =
    {
        isDynamic = false,
        ValueHandler =
        {
            defaultValue = 8,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true, [10] = true, [12] = true, },
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
                    eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = TheEyeAddon.Values.cooldownEndAlertLength,
                        type = "LessThan"
                    },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_STACK_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 194249, },
                    comparisonValues =
                    {
                        value = 9,
                        type = "GreaterThan"
                    },
                    value = 8,
                },
            },
        },
    },
}
)