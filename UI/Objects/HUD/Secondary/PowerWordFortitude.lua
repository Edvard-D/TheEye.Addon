local parentKey = "HUD_MODULE_SECONDARY"
local spellID = 211681

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "SECONDARY", "SPELL-211681", },
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
            value = 6,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [0] = true },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] spellID },
                    value = 2,
                },
            },
        },
    },
}
)