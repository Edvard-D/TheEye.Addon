local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 280711

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-280711", },
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
            validKeys = { [6] = true, },
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
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] 21978, },
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
            value = 10,
        },
    },
    ReadySoonAlert =
    {
        spellID = spellID
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys =
            {
                [2] = true, [4] = true, [6] = true, [8] = true, [10] = true,
                [34] = true, [36] = true, [38] = true, [40] = true, [42] = true, 
                [50] = true, [52] = true, [54] = true, [56] = true, [58] = true, 
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
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "ReadySoonAlert" },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo",
                    },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "UNIT_POWER_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "player", --[[powerType]] "INSANITY", },
                    comparisonValues =
                    {
                        value = 0.75,
                        type = "GreaterThan"
                    },
                    value = 16,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 194249, },
                    value = 32,
                },
            },
        },
    },
}
)