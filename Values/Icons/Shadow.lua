--[[ Spell Priorities
1	232698	Shadowform
2	194249	Voidform
3	193223	Surrender to Madness
4	228260	Void Eruption
5	280711	Dark Ascension
6	205448	Void Bolt (1-9 enemies)
7	32379	Shadow Word: Death (2 charges, 1-4 enemies)
8	34433	Shadowfiend
9	200174	Mindbender (6+ Voidform stacks)
10	211522	Psyfiend
11	263346	Dark Void (3+ enemies)
12	205385	Shadow Crash (3+ enemies)
13	205351	Shadow Word: Void (1-5 enemies)
14	8092	Mind Blast (1-4 enemies)
15	32379	Shadow Word: Death (-Voidform, 1 charge, 1-4 enemies)
16	263346	Dark Void (1-2 enemies)
17	205385	Shadow Crash (1-2 enemies)
18	263165	Void Torrent (1-4 enemies)
19	589	Shadow Word: Pain
20	34914	Vampiric Touch
21	48045	Mind Sear (3+ enemies)
22	15407	Mind Flay (1-2 enemies)
23	208683	Gladiator's Medallion
24	108968	Void Shift
25	47585	Dispersion
26	15286	Vampiric Embrace
27	213602	Greater Fade
28	586	Fade
29	15487	Silence
30	64044	Psychic Horror
31	205369	Mind Bomb
32	8122	Psychic Scream
33	72734	Mass Dispel
34	528	Dispel Magic
35	186263	Shadow Mend
36	17	Power Word: Shield
37	73325	Leap of Faith
38	213634	Purify Disease
39	21562	Power Word: Fortitude
40	2096	Mind Vision
41	1706	Levitate
]]



-- Dark Ascension
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 5, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 194249, -- Voidform
        },
        {
            type = "AURA_REQUIRED",
            value = 232698, -- Shadowform
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 50,
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
            [0] = 16,
            [2] = 11,
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 30,
        },
        {
            type = "TALENT_REQUIRED",
            value = 23127,
        },
    },
})

-- Dispel Magic
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 34, },
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "REMOVE_BUFF",
        },
        {
            type = "OBJECT_ID",
            value = 528,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Dispersion
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 25, },
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
        validKeys = { [0] = 28, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 586,
        },
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
        {
            type = "TALENT_REQUIRED",
            value = 3753, -- Greater Fade
            isInverse = true,
        },
    },
})

-- Gladiator's Medallion
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 23, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 208683,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "REMOVE_DEBUFF",
            subvalue = "CC",
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

-- Greater Fade
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 27, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 213602,
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
            value = 45,
        },
        {
            type = "OBJECT_ID",
            value = 213602,
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
            value = 3753,
        },
    },
})

-- Leap of Faith
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 37, }
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

-- Levitate
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 41, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 111759,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "UTILITY",
            subvalue = "NON-COMBAT",
        },
        {
            type = "OBJECT_ID",
            value = 1706,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
    },
})

-- Mass Dispel
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 33, },
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

-- Mind Blast
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 14, },
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 14,
        },
        {
            type = "TALENT_REQUIRED",
            value = 22136, -- Shadowy Insight
        },
        {
            type = "TALENT_REQUIRED",
            value = 22328, -- Fortress of the Mind
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
        validKeys = { [0] = 31, },
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
        validKeys = { [0] = 22, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 15407,
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
            type = "OBJECT_ID",
            value = 15407,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
        },
        {
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 14,
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
        validKeys = { [0] = 21, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 48045,
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

-- Mind Vision
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 40, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 2096,
        },
        {
            type = "CAST_TYPE",
            value = "CHANNEL",
        },
        {
            type = "CATEGORY",
            value = "UTILITY",
            subvalue = "NON-COMBAT",
        },
        {
            type = "OBJECT_ID",
            value = 2096,
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
        validKeys = { [0] = 9, },
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 72,
        },
        {
            type = "TALENT_REQUIRED",
            value = 21719,
        },
    },
})

-- Power Word: Fortitude
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 39, },
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
        {
            type = "POWER_REQUIRED",
        },
    },
})

-- Power Word: Shield
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 36, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 17,
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
            type = "OBJECT_ID",
            value = 17,
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

-- Psychic Horror
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 30, },
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
        validKeys = { [0] = 32, },
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
            value = 21752, -- Psychic Horror
        },
        {
            type = "TALENT_REQUIRED",
            value = 23137, -- Last Word
        },
    },
})

-- Psyfiend
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 10, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 211522,
        },
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "DAMAGE",
            subvalue = "SUMMON",
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
            value = 763,
        },
    },
})

-- Purify Disease
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 38, },
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "INSTANT",
        },
        {
            type = "CATEGORY",
            value = "REMOVE_DEBUFF",
            subvalue = "DISEASE",
        },
        {
            type = "COOLDOWN",
            value = 8,
        },
        {
            type = "OBJECT_ID",
            value = 213634,
        },
        {
            type = "OBJECT_TYPE",
            value = "SPELL",
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
            [0] = 17,
            [2] = 12,
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 20,
        },
        {
            type = "TALENT_REQUIRED",
            value = 21755,
        },
    },
})

-- Shadow Mend
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 35, },
    },
    properties =
    {
        {
            type = "CAST_TYPE",
            value = "CAST",
        },
        {
            type = "CATEGORY",
            value = "HEAL",
        },
        {
            type = "OBJECT_ID",
            value = 186263,
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

-- Shadow Word: Death
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys =
        {
            [0] = 15, [2] = 15, [8] = 15,
            [4] = 7, [6] = 7, [10] = 7, [12] = 7, [14] = 7,
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
            value = 0.2,
            comparison = "LessThan",
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 15,
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
        validKeys = { [0] = 19, },
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
        {
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 4,
        },
    },
})

-- Shadow Word: Void
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 13, },
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 15,
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

-- Shadowfiend
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 8, },
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 36,
        },
        {
            type = "TALENT_REQUIRED",
            value = 21718, -- Lingering Insanity
        },
        {
            type = "TALENT_REQUIRED",
            value = 21720, -- Void Torrent
        },
    },
})

-- Shadowform
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 1, },
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

-- Silence
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 29, },
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
        validKeys = { [0] = 3, },
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
            value = 180,
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = "x2",
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
        validKeys = { [0] = 26, },
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
            subvalue = "PERIODIC",
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
        validKeys = { [0] = 20, },
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
        {
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 6,
        },
    },
})

-- Void Bolt
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 6, },
    },
    properties =
    {
        {
            type = "AURA_REQUIRED",
            value = 194249, -- Voidform
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 20,
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
        validKeys = { [0] = 4, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 194249, -- Voidform
        },
        {
            type = "AURA_REQUIRED",
            value = 232698, -- Shadowform
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

-- Void Shift
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 24, }
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
        validKeys = { [0] = 18, },
    },
    properties =
    {
        {
            type = "AURA_APPLIED",
            value = 289577,
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
            type = "POWER_MODIFIED",
            value = 13, -- INSANITY
            subvalue = 30,
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

-- Voidform
TheEyeAddon.Managers.Icons.Add(258,
{
    PriorityRank =
    {
        validKeys = { [0] = 4, },
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