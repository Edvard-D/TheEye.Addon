-- Dark Ascension
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 26, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 194249,
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
            value = 60,
        },
        {
            type = "OBJECT_ID",
            value = 280711,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 21978,
        },
    },
})

-- Dark Void
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = {
            [0] = 17,
            [2] = 21,
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
            type = "AURA_APPLIED",
            value = 589, -- Shadow Word: Pain
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
    },
})

-- Dispersion
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 10, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 47585,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "DEFENSIVE",
        },
        {
            type = "COOLDOWN",
            value = 120,
        },
        {
            type = "OBJECT_ID",
            value = 47585,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Fade
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 11, }
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "DEFENSIVE",
            subvalue = "THREAT",
        },
        {
            type = "COOLDOWN",
            value = 30,
        },
        {
            type = "OBJECT_ID",
            value = 586,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Gladiator's Medallion
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 9, }
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "DEFENSIVE",
        },
        {
            type = "COOLDOWN",
            value = 120,
        },
        {
            type = "OBJECT_ID",
            value = 208683,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "PVP_REQUIRED",
        },
        {
            type = "TALENT_REQUIRED",
            value = 3476,
        },
    },
})

-- Leap of Faith
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 1, }
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "UTILITY",
        },
        {
            type = "COOLDOWN",
            value = 90,
        },
        {
            type = "OBJECT_ID",
            value = 73325,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Mass Disepl
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 5, }
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "CAST",
        },
        {
            type = "CATEGORY",
            value = "REMOVE_BUFF",
            subvalue = "MAGIC",
        },
        {
            type = "CATEGORY",
            value = "REMOVE_DEBUFF",
            subvalue = "MAGIC",
        },
        {
            type = "COOLDOWN",
            value = 45,
        },
        {
            type = "OBJECT_ID",
            value = 32375,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Mindbender
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 23, }
    },
    properties =
    {
        {
            type = "AURA_REQUIRED",
            comparison = "GreaterThanEqualTo",
            stacks = 6,
            value = 194249,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
            subvalue = "TOTEM",
        },
        {
            type = "COOLDOWN",
            value = 60,
        },
        {
            type = "OBJECT_ID",
            value = 200174,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 21719,
        },
    },
})

-- Mind Blast
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 19, }
    },
    properties =
    {
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
            type = "UNITS_NEAR_MAX",
            value = 4,
        },
    },
})

-- Mind Bomb
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 2, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 205369,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "CC",
        },
        {
            type = "CATEGORY",
            value = "REMOVE_DEBUFF",
        },
        {
            type = "COOLDOWN",
            value = 30,
        },
        {
            type = "OBJECT_ID",
            value = 205369,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 23375,
        },
    },
})

-- Mind Flay
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 12, }
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "CHANNEL",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
        },
        {
            type = "OBJECT_ID",
            value = 15407,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "UNITS_NEAR_MAX",
            value = 2,
        },
    },
})

-- Mind Sear
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 12, }
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "CHANNEL",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
        },
        {
            type = "OBJECT_ID",
            value = 48045,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "UNITS_NEAR_MIN",
            value = 3,
        },
    },
})

-- Power Word Fortitude
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 6, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 21562,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "BUFF",
            subvalue = "SURVIVABILITY",
        },
        {
            type = "OBJECT_ID",
            value = 21562,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Psychic Horror
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 3, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 64044,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "CC",
        },
        {
            type = "COOLDOWN",
            value = 45,
        },
        {
            type = "OBJECT_ID",
            value = 64044,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 21752,
        },
    },
})

-- Psychic Scream
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 2, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 8122,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "CC",
        },
        {
            type = "COOLDOWN",
            value = 60,
        },
        {
            type = "OBJECT_ID",
            value = 8122,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 21752,
        },
        {
            type = "TALENT_REQUIRED",
            value = 23137,
        },
    },
})

-- Psyfiend
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 22, }
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
            subvalue = "SUMMON",
            length = 12,
        },
        {
            type = "COOLDOWN",
            value = 45,
        },
        {
            type = "OBJECT_ID",
            value = 211522,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "PVP_REQUIRED",
        },
        {
            type = "TALENT_REQUIRED",
            value = 736,
        },
    },
})

-- Shadow Crash
TheEyeAddon.Managers.Icons.Add(258,
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
    },
})

-- Shadowfiend
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 23, }
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
            subvalue = "TOTEM",
        },
        {
            type = "COOLDOWN",
            value = 180,
        },
        {
            type = "OBJECT_ID",
            value = 34433,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 21718,
        },
        {
            type = "TALENT_REQUIRED",
            value = 21720,
        },
    },
})

-- Shadowform
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = math.huge, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 232698,
        },
        {
            type = "AURA_REPLACED",
            value = 194249, -- Voidform
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "BUFF",
            subvalue = "POWER",
        },
        {
            type = "OBJECT_ID",
            value = 232698,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Shadow Word: Death
TheEyeAddon.Managers.Icons.Add(258,
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
            type = "UNITS_NEAR_MAX",
            value = 4,
        },
    },
})

-- Shadow Word: Pain
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 14, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 589,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
            subvalue = "PERIODIC",
        },
        {
            type = "OBJECT_ID",
            value = 589,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Shadow Word: Void
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 19, }
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "CAST",
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
            type = "OBJECT_ID",
            value = 205351,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 22314,
        },
        {
            type = "UNITS_NEAR_MAX",
            value = 5,
        },
    },
})

-- Silence
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 4, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 15487,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "CC",
        },
        {
            type = "COOLDOWN",
            value = 45,
        },
        {
            type = "OBJECT_ID",
            value = 15487,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Surrender to Madness
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 28, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 193223,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "BUFF",
            subvalue = "POWER",
        },
        {
            type = "COOLDOWN",
            value = 240,
        },
        {
            type = "OBJECT_ID",
            value = 193223,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 21979,
        },
    },
})

-- Vampiric Embrace
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 8, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 15286,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "HEAL",
            subvalue = "HOT",
        },
        {
            type = "COOLDOWN",
            value = 120,
        },
        {
            type = "OBJECT_ID",
            value = 15286,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Vampiric Touch
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 13, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 589, -- Shadow Word: Pain
            requirement =
            {
                type = "TALENT_REQUIRED",
                value = 23126, -- Misery
            },
        },
        {
            type = "AURA_APPLIED",
            value = 34914,
        },
        {
            type = "CAST_TYPE",
            value = "CAST",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
            subvalue = "PERIODIC",
        },
        {
            type = "OBJECT_ID",
            value = 34914,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Void Bolt
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 25, }
    },
    properties =
    {
        {
            type = "AURA_REQUIRED",
            value = 194249,
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
            value = 4.5,
        },
        {
            type = "OBJECT_ID",
            value = 205448,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "UNITS_NEAR_MAX",
            value = 9,
        },
    },
})

-- Void Eruption
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 26, }
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 194249,
        },
        {
            type = "AURA_REQUIRED",
            value = 232698,
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
            type = "OBJECT_ID",
            value = 228260,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "POWER_REQUIRED",
        },
    },
})

-- Voidform
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 27, }
    },
    properties =
    {
        {
            type = "AURA_REPLACED",
            value = 232698, -- Shadowform
        },
        {
            type = "CAST_TYPE",
            value = "TRIGGERED",
        },
        {
            type = "CATEGORY",
            value = "BUFF",
            subvalue = "POWER",
        },
        {
            type = "OBJECT_ID",
            value = 194249,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Void Shift
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 7, }
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "HEAL",
        },
        {
            type = "COOLDOWN",
            value = 300,
        },
        {
            type = "OBJECT_ID",
            value = 108968,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "PVP_REQUIRED",
        },
        {
            type = "TALENT_REQUIRED",
            value = 128,
        },
    },
})

-- Void Torrent
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 15, }
    },
    properties =
    {
        {
            type = "AURA_REQUIRED",
            value = 194249,
        },
        {
            type = "CAST_TYPE",
            value = "CHANNEL",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
        },
        {
            type = "COOLDOWN",
            value = 45,
        },
        {
            type = "OBJECT_ID",
            value = 263165,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "TALENT_REQUIRED",
            value = 21720,
        },
        {
            type = "UNITS_NEAR_MAX",
            value = 4,
        },
    },
})