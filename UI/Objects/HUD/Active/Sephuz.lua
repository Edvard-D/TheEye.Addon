local parentKey = "HUD_MODULE_ACTIVE"
local spellID = 208052

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "ACTIVE", "SPELL-208052", },
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
            validKeys = { [6] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UIOBJECT_VISIBLE_CHANGED",
                    inputValues = { --[[uiObjectKey]] parentKey, },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "PLAYER_ITEM_EQUIPPED_CHANGED",
                    inputValues = { --[[itemID]] 132452, },
                    value = 4,
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
            defaultValue = 4,
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
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "player", --[[spellID]] spellID, },
                    value = 2,
                },
            },
        },
    },
}
)