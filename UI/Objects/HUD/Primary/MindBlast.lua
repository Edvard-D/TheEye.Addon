local spellID = 8092

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-8092", },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon.Large,
        iconObjectType = "SPELL",
        iconObjectID = spellID,
    },
    -- @TODO cooldown
    -- @TODO show charges
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
                    inputValues = { --[[uiObjectKey]] "HUD_MODULE_PRIMARY", },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] 22314, },
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
            validKeys = { [4] = true, [6] = true, [10] = true, [14] = true,  },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = TheEyeAddon.Values.castStartHideDelay,
                        type = "LessThan"
                    },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                    inputValues = { --[[spellID]] spellID },
                    comparisonValues =
                    {
                        value = TheEyeAddon.Values.cooldownEndAlertLength,
                        type = "LessThan"
                    },
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