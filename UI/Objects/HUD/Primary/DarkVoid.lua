local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 263346

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-263346", },
    Child =
    {
        parentKey = parentKey,
    },
    Cooldown =
    {
        Listener =
        {
            eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
            inputValues = { --[[spellID]] spellID },
            comparisonValues =
            {
                value = TheEyeAddon.Values.cooldownEndAlertLength,
                type = "LessThan"
            },
        }
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
                    inputValues = { --[[uiObjectKey]] parentKey, },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] 23127, },
                    value = 4,
                },
            },
        },
    },
    Icon =
    {
        DisplayData =
        {
            DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon.Large,
            iconObjectType = "SPELL",
            iconObjectID = spellID,
        },
    },
    PriorityRank =
    {
        isDynamic = false,
        ValueHandler =
        {
            value = 4,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [4] = true, [6] = true, [8] = true, [14] = true },
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
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                    inputValues = { --[[spellID]] spellID },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo",
                    },
                    value = 8,
                },
            },
        },
    },
}
)