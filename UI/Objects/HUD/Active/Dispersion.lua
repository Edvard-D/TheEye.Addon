local parentKey = "HUD_MODULE_ACTIVE"
local spellID = 47585

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "ACTIVE", "SPELL-47585", },
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
                    inputValues = { --[[uiObjectKey]] parentKey },
                    value = 2,
                },
            },
        },
    },
    Parent =
    {
        key = parentKey,
    },
    PriorityRank =
    {
        isDynamic = false,
        ValueHandler =
        {
            defaultValue = 1,
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
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] 47585, },
                    value = 2,
                },
            },
        },
    },
}
)