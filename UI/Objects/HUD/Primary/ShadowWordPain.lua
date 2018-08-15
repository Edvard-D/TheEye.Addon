local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 589

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-589" },
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
            value = 12,
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
                [2] = true, [4] = true, [6] = true, [8] = true, [10] = true, [18] = true, [20] = true, [22] = true,
                [26] = true, [34] = true, [36] = true, [38] = true, [40] = true, [42] = true, [50] = true,
                [54] = true, [58] = true,
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
                    eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo"
                    },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "PLAYER_TALENT_KNOWN_CHANGED",
                    inputValues = { --[[talentID]] 23126, }, -- Misery
                    value = 16,
                },
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] "HUD_ICON_PRIMARY_SPELL-34914", --[[componentName]] "VisibleState" }, -- Vampiric Touch
                    value = 32,
                },
            },
        },
    },
}
)