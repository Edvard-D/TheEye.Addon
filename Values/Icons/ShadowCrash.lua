TheEyeAddon.Managers.Icons.Add(
{
    PriorityRank =
    {
        validKeys =
        {
            [0] = 16,
            [2] = 20,
        },
        listeners =
        {
            {
                eventEvaluatorKey = "UNIT_COUNT_CLOSE_TO_UNIT_CHANGED",
                inputValues = { --[[unit]] "target", --[[hostilityMask]] COMBATLOG_OBJECT_REACTION_HOSTILE, },
                comparisonValues =
                {
                    value = 3,
                    type = "GreaterThanEqualTo"
                },
                value = 2,
            },
        },
    },
    properties =
    {
        {
            type = "AFFECTED",
            value = "MULTIPLE",
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
        },
        {
            type = "COOLDOWN",
            value = 20,
        },
        {
            type = "OBJECT_ID",
            value = 205385,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 21755,
        },
        {
            type = "TARGETING",
            value = "POSITIONAL",
        },
        {
            type = "USAGE_RATE",
            value = 4,
        },
    },
}
)