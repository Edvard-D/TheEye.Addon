local spellID = 193223

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "ACTIVE", "SPELL-193223", },
    -- @TODO Remaining time
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon.Medium,
        iconObjectType = "SPELL",
        iconObjectID = spellID,
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
                    inputValues = { --[[uiObjectKey]] "HUD_MODULE_ACTIVE", },
                    value = 2,
                },
            },
        },
    },
    PriorityRank =
    {
        isDynamic = false,
        ValueHandler =
        {
            defaultValue = 5,
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
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 193223, },
                    value = 2,
                },
            },
        },
    },
}
)