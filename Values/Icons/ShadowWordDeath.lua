TheEyeAddon.Managers.Icons.Add(
{
    PriorityRank =
    {
        validKeys =
        {
            [0] = 18, [2] = 18, [8] = 18,
            [4] = 24, [6] = 24, [10] = 24, [12] = 24, [14] = 24,
        },
        listeners =
        {
            {
                eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                inputValues = { --[[spellID]] 32379, },
                comparisonValues =
                {
                    value = 1,
                    type = "EqualTo",
                },
                value = 2,
            },
            {
                eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                inputValues = { --[[spellID]] 32379, },
                comparisonValues =
                {
                    value = 2,
                    type = "EqualTo",
                },
                value = 4,
            },
            {
                eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "CastSoonAlert" },
                value = 8,
            },
        },
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
        },
        {
            type = "CHARGES",
            value = 2,
        },
        {
            type = "COOLDOWN",
            value = 9,
        },
        {
            type = "HEALTH_REQUIRED",
            comparison = "LessThan",
            value = 0.2,
        },
        {
            type = "OBJECT_ID",
            value = 32379,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 22311,
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
            value = 4,
        },
    },
}
)