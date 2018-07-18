local spellID = 32379

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-32379", },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = spellID,
        fontTemplate = TheEyeAddon.UI.Fonts.Templates.Icon.default,
    },
    -- @TODO cooldown
        -- @TODO show charges
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
                    eventEvaluatorKey = "PLAYER_TALENT_ACTIVE_CHANGED",
                    inputValues = { --[[tier]] 5, --[[column]] 2, },
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
            defaultValue = 3,
        },
    },
    VisibleState = -- @TODO possibly change so it's visible when there's one stack currently and the cooldown for two is about to end
    {
        ValueHandler =
        {
            validKeys = { [6] = true, [8] = true, [18] = true, [22] = true, [26] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "target", },
                    comparisonValues =
                    {
                        value = 0.2,
                        type = "LessThan",
                    },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "GreaterThan",
                    },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_START_RECENTLY_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = TheEyeAddon.Values.cooldownEndAlertLength,
                        type = "LessThan"
                    },
                    value = 16,
                },
            },
        },
    },
}
)