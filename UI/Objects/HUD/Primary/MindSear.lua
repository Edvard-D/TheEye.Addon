local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 48045

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-48045", },
    CastStartAlert =
    {
        spellID = spellID,
    },
    Child =
    {
        parentKey = parentKey,
    },
    ContextIcon =
    {
        ValueHandler =
        {
            validKeys = { [0] = true, },
        },
        iconObjectType = "SPELL",
        iconObjectID = 277702, -- crosshair symbol
        TextValueListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_COUNT_CLOSE_TO_UNIT_CHANGED",
                    inputValues = { --[[unit]] "target", --[[hostilityMask]] COMBATLOG_OBJECT_REACTION_HOSTILE, },
                },
            },
        },
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
            validKeys = { [0] = 1, }
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [8] = true, [10] = true, [14] = true, },
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
                    eventEvaluatorKey = "UNIT_COUNT_CLOSE_TO_UNIT_CHANGED",
                    inputValues = { --[[unit]] "target", --[[hostilityMask]] COMBATLOG_OBJECT_REACTION_HOSTILE, },
                    comparisonValues =
                    {
                        value = 3,
                        type = "GreaterThanEqualTo"
                    },
                    value = 8,
                },
            },
        },
    },
}
)