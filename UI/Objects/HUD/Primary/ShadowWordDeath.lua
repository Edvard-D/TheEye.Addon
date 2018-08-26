local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 32379

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-32379", },
    CastStartAlert =
    {
        spellID = spellID,
    },
    Child =
    {
        parentKey = parentKey,
    },
    -- @TODO show charges
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
        ValueHandler =
        {
            validKeys = { [0] = 4, }
        },
    },
    ReadySoonAlert =
    {
        spellID = spellID
    },
    VisibleState = -- @TODO possibly change so it's visible when there's one stack currently and the cooldown for two is about to end
    {
        ValueHandler =
        {
            validKeys =
            {
                [66] = true, [114] = true, [116] = true, [118] = true, [120] = true, [122] = true,
                [126] = true, 
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
                    eventEvaluatorKey = "UNIT_HEALTH_PERCENT_CHANGED",
                    inputValues = { --[[unit]] "target", },
                    comparisonValues =
                    {
                        value = 0.2,
                        type = "LessThan",
                    },
                    value = 16,
                },
                {
                    eventEvaluatorKey = "PLAYER_SPELL_CHARGE_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "GreaterThan",
                    },
                    value = 32,
                },
                {
                    eventEvaluatorKey = "UNIT_COUNT_CLOSE_TO_UNIT_CHANGED",
                    inputValues = { --[[unit]] "target", --[[hostilityMask]] COMBATLOG_OBJECT_REACTION_HOSTILE, },
                    comparisonValues =
                    {
                        value = 4,
                        type = "LessThanEqualTo"
                    },
                    value = 64,
                },
            },
        },
    },
}
)