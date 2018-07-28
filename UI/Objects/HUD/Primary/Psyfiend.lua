local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 211522

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-211522", },
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
            validKeys = { [14] = true, },
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
                    inputValues = { --[[talentID]] 763, },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_PVP_FLAGGED_CHANGED",
                    inputValues = { --[[unit]] "player" },
                    value = 8,
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
            value = 5,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true, [4] = true, [6] = true },
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
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo",
                    },
                    value = 4,
                },
            },
        },
    },
}
)