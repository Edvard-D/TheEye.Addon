local parentKey = "HUD_MODULE_ACTIVE"
local spellID = 194249

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "ACTIVE", "SPELL-194249", },
    Child =
    {
        parentKey = parentKey,
    },
    -- @TODO Insanity percent below 50%
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
        Dimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Medium,
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
            validKeys = { [0] = 7, }
        },
    },
    VisibleState =
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
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 194249, },
                    value = 2,
                },
            },
        },
    },
}
)