local spellID = 32379

TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-32379", },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = spellID,
        fontTemplate = TheEyeAddon.UI.Fonts.Templates.Icon.default,
        -- @TODO show charges
    },
    -- @TODO cooldown
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
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY", },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "TALENT_ACTIVE_CHANGED",
                    inputValues = { --[[tier]] 5, --[[column]] 2, },
                    value = 4,
                },
            },
        },
    },
    PriorityRank =
    {
        isDynamic = false,
        ValueHandler =
        {
            defaultValue = 2,
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [6] = true, [8] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_HEALTH_CHANGED",
                    inputValues = { --[[unit]] "target", },
                    comparisonValues =
                    {
                        value = 20,
                        type = "LessThan",
                    },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "SPELL_CHARGE_CHANGED",
                    inputValues = { --[[spellID]] spellID, },
                    comparisonValues =
                    {
                        value = 0,
                        type = "GreaterThan",
                    },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_SPELLCAST_START_RECENTLY_CHANGED",
                    inputValues = { --[[unit]] "player", --[[spellID]] spellID, },
                    value = 8,
                },
            },
        },
    },
}
)

--[[
{
    UNIT_HEALTH_CHANGED -- LessThan -- 20
    and
    SPELL_CHARGE_CHANGED -- GreaterThan -- 0
}
or
UNIT_SPELLCAST_START_RECENTLY_CHANGED
]]