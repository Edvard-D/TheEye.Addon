TheEyeAddon.Managers.Icons.Add(
{
    PriorityRank =
    {
        validKeys = {
            [0] = 6,
            [2] = 10,
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
        }
    },
    properties =
    {
        {
            type = "AFFECTED",
            value = "MULTIPLE",
        },
        {
            type = "CAST_TYPE",
            value = "CAST",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
        },
        {
            type = "COOLDOWN",
            value = 30,
        },
        {
            type = "OBJECT_ID",
            value = 263346,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 23127,
        },
        {
            type = "TARGETING",
            value = "DIRECT",
        },
        {
            type = "USAGE_RATE",
            value = 4,
        },
    },
}
)