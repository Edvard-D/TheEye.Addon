TheEyeAddon.Managers.Icons.Add(
{
    PriorityRank =
    {
        validKeys = { [0] = 8, }
    },
    properties =
    {
        {
            type = "AFFECTED",
            value = "SINGLE",
        },
        {
            type = "CAST_TYPE",
            value = "CAST",
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
            requirement =
            {
                type = "AURA_REQUIRED",
                value = 124430, -- Shadowy Insight
            },
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
        },
        {
            type = "COOLDOWN",
            value = 7.5,
        },
        {
            type = "OBJECT_ID",
            value = 8092,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 22136,
        },
        {
            type = "TALENT_REQUIRED",
            value = 22328,
        },
        {
            type = "TARGETING",
            value = "DIRECT",
        },
        {
            type = "UNITS_NEAR_MAX",
            value = 4,
        },
        {
            type = "USAGE_RATE",
            value = 5,
        },
    },
}
)