local parentKey = "HUD_MODULE_COOLDOWN"
local spellID = 211522

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "COOLDOWN", "SPELL-211522", },
    Child =
    {
        parentKey = parentKey,
    },
    Cooldown =
    {
        spellID = spellID
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
                    inputValues = { --[[talentID]] 763, },
                    value = 4,
                },
            },
        },
    },
    Icon =
    {
        DisplayData =
        {
            DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon.Small,
            iconObjectType = "SPELL",
            iconObjectID = spellID,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [10] = true },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "Cooldown" },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] "HUD_ICON_PRIMARY_SPELL-211522", --[[componentName]] "VisibleState" },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_SUCCEEDED_ELAPSED_TIME_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID },
                    comparisonValues =
                    {
                        value = 12,
                        type = "GreaterThan"
                    },
                    value = 8,
                },
            },
        },
    },
}
)