local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 32379

TheEyeAddon.Managers.UI.FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-32379", },
    CastSoonAlert =
    {
        spellID = spellID
    },
    CastStartAlert =
    {
        spellID = spellID,
    },
    Charges =
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
                    inputValues = { --[[talentID]] 22311, },
                    value = 4,
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
            validKeys =
            {
                [0] = 7, [2] = 7, [8] = 7,
                [4] = 13, [6] = 13, [10] = 13, [12] = 13, [14] = 13,
            }
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                inputValues = { --[[spellID]] spellID, },
                comparisonValues =
                {
                    value = 1,
                    type = "EqualTo",
                },
                value = 2,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
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
            }
        },
    },
    VisibleState = -- @TODO possibly change so it's visible when there's one stack currently and the cooldown for two is about to end
    {
        ValueHandler =
        {
            validKeys =
            {
                [130] = true, [132] = true, [134] = true, [140] = true, [142] = true, [152] = true,
                [154] = true, [156] = true, [158] = true, [168] = true, [170] = true, [172] = true,
                [174] = true, [222] = true, [232] = true, [234] = true, [236] = true, [238] = true,
                [254] = true, [280] = true, [282] = true, [284] = true, [286] = true,
            },
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
                    inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "CastSoonAlert" },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "target", },
                    comparisonValues =
                    {
                        value = 0.2,
                        type = "LessThan",
                    },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 1,
                        type = "EqualTo",
                    },
                    value = 16,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 2,
                        type = "EqualTo",
                    },
                    value = 32,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 194249, },
                    value = 64,
                },
                {
                    eventEvaluatorKey = "UNIT_COUNT_CLOSE_TO_UNIT_CHANGED",
                    inputValues = { --[[unit]] "target", --[[hostilityMask]] COMBATLOG_OBJECT_REACTION_HOSTILE, },
                    comparisonValues =
                    {
                        value = 2,
                        type = "LessThanEqualTo"
                    },
                    value = 128,
                },
            },
        },
    },
}
)