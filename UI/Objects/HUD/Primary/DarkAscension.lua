local spellID = 280711

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-280711", },
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
            validKeys = { [6] = true, },
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
                    inputValues = { --[[talentID]] 21978, },
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
            defaultValue = 9,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true, [4] = true, [6] = true, [10] = true, [14] = true }
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
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 194249, },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "UIOBJECT_VISIBLE_CHANGED",
                    inputValues = { --[[uiObjectKey]] "HUD_ICON_PRIMARY_SPELL-228260" },
                    value = 16,
                },
            },
        },
    },
}
)