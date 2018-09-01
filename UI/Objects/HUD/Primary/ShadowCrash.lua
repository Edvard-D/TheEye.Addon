local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 205385

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-205385", },
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
                    inputValues = { --[[talentID]] 21755, },
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
            validKeys = { [0] = 7, }
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
            validKeys = { [2] = true, [4] = true, [6] = true, [8] = true, [10] = true, },
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
                    inputValues = { --[[spellID]] spellID },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo",
                    },
                    value = 8,
                },
            },
        },
    },
}
)