local parentKey = "HUD_MODULE_COOLDOWN"
local spellID = 208683

TheEyeAddon.UI.Objects:FormatData(
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
                    inputValues = { --[[talentID]] 3476, },
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