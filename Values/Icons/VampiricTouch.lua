TheEyeAddon.Managers.Icons.Add(
{
    PriorityRank =
    {
        validKeys = { [0] = 2, }
    },
    properties =
    {
        {
            type = "AFFECTED",
            value = "SINGLE",
        },
        {
            type = "AURA",
        },
        {
            type = "CAST_TYPE",
            value = "CAST",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
            subvalue = "DOT",
        },
        {
            type = "OBJECT_ID",
            value = 34914,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "SUBSTITUTES",
            value = 589, -- Shadow Word: Pain
            requirement =
            {
                type = "TALENT_REQUIRED",
                value = 23126, -- Misery
            },
        },
        {
            type = "TARGETING",
            value = "DIRECT",
        },
        {
            type = "USAGE_RATE",
            value = 5,
        },
    },
}
)