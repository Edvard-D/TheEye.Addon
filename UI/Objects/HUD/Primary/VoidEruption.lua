local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 228260

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-228260", },
    CastStartAlert =
    {
        spellID = spellID,
    },
    Child =
    {
        parentKey = parentKey,
    },
    EnabledState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObjectKey]] parentKey, --[[componentName]] "VisibleState" },
                    value = 2,
                },
            },
        },
    },
    Frame =
    {
        Dimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Large,
    },
    Icon =
    {
        iconObjectType = "SPELL",
        iconObjectID = spellID,
    },
    PriorityRank =
    {
        ValueHandler =
        {
            validKeys = { [0] = 13, }
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys =
            {
                [2] = true, [6] = true, [16] = true, [18] = true, [20] = true, [24] = true, [26] = true,
                [30] = true, [58] = true, [72] = true, [74] = true, [78] = true, [88] = true, [90] = true,
                [94] = true, [106] = true, [122] = true,
            }
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "CastStartAlert" },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_POWER_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "player", --[[powerType]] "INSANITY", },
                    comparisonValues =
                    {
                        value = 0.6,
                        type = "GreaterThanEqualTo"
                    },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "UNIT_POWER_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "player", --[[powerType]] "INSANITY", },
                    comparisonValues =
                    {
                        value = 0.9,
                        type = "GreaterThanEqualTo"
                    },
                    value = 16,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 194249, },
                    value = 32,
                },
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] 21637, },
                    value = 64,
                },
            },
        },
    },
}
)