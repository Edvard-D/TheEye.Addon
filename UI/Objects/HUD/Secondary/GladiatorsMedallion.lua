local parentKey = "HUD_MODULE_SECONDARY"
local spellID = 208683

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "SECONDARY", "SPELL-208683", },
    Child =
    {
        parentKey = parentKey,
    },
    EnabledState =
    {
        ValueHandler =
        {
            validKeys = { [14] = true, },
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
                    inputValues = { --[[talentID]] 3476, },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_PVP_FLAGGED_CHANGED",
                    inputValues = { --[[unit]] "player" },
                    value = 8,
                },
            },
        },
    },
    Frame =
    {
        DisplayData =
        {
            DimensionTemplate = TheEyeAddon.Values.DimensionTemplates.Icon.Medium,
        },
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
            validKeys = { [0] = 9, }
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "PLAYER_SPELL_COOLDOWN_DURATION_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "EqualTo",
                    },
                    value = 2,
                },
                -- @TODO Don't show unless doing PvP content
            },
        },
    },
}
)