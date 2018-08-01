local parentKey = "HUD_MODULE_PRIMARY"
local spellID = 34914

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-34914" },
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
                    eventEvaluatorKey = "UIOBJECT_VISIBLE_CHANGED",
                    inputValues = { --[[uiObjectKey]] parentKey, },
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
            value = 11,
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
            validKeys = { [2] = true, [4] = true, [6] = true, [10] = true, [14] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_START_ELAPSED_TIME_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = TheEyeAddon.Values.castStartHideDelay,
                        type = "LessThan"
                    },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_DURATION_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = TheEyeAddon.Values.cooldownEndAlertLength,
                        type = "LessThan"
                    },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_ACTIVE_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 8,
                },
            },
        },
    },
}
)