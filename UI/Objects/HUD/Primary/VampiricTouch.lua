local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 34914

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-34914" },
    CastSoonAlert =
    {
        spellID = spellID
    },
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
            validKeys = { [6] = true, [10] = true, [14] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] 23126, }, -- Misery
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] 589, }, -- Shadow Word: Pain
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo"
                    },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] "HUD_ICON_PRIMARY_SPELL-589", --[[componentName]] "CastSoonAlert" },
                    value = 8,
                },
            },
        },
        iconObjectType = "SPELL",
        iconObjectID = 589,
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
            validKeys = { [0] = 2, }
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true, [4] = true, [10] = true, [16] = true, [18] = true, [26] = true, },
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
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo"
                    },
                    value = 16,
                },
            },
        },
    },
}
)