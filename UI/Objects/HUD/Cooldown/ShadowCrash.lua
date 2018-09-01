local parentKey = "HUD_MODULE_COOLDOWN"
local spellID = 205385

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "COOLDOWN", "SPELL-205385", },
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
                    inputValues = { --[[talentID]] 21755, },
                    value = 4,
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
                {
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObject]] "HUD_ICON_PRIMARY_SPELL-205385", --[[componentName]] "VisibleState" },
                    value = 4,
                },
            },
        },
    },
}
)