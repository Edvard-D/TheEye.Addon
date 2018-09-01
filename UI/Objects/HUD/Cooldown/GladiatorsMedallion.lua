local parentKey = "HUD_MODULE_COOLDOWN"
local spellID = 208683

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "COOLDOWN", "SPELL-208683", },
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
            DimensionTemplate = TheEyeAddon.Values.DimensionTemplates.Icon.Small,
        },
    },
    Icon =
    {
        iconObjectType = "SPELL",
        iconObjectID = spellID,
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
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] "#SELF#UIOBJECT#KEY#", --[[componentName]] "Cooldown" },
                    value = 2,
                },
            },
        },
    },
}
)