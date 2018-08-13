local parentKey = "HUD_MODULE_SECONDARY"
local spellID = 586

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "SECONDARY", "SPELL-586", },
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
            DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon.Medium,
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
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [6] = true },
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
                {
                    eventEvaluatorKey = "UNIT_THREAT_SITUATION_CHANGED",
                    inputValues = { --[[unit]] "player", --[[otherUnit]] "_", },
                    comparisonValues =
                    {
                        value = 1,
                        type = "GreaterThanEqualTo",
                    },
                    value = 4,
                },
                -- @TODO Don't show unless doing content in a group
            },
        },
    },
}
)