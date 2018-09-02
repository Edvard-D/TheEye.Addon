local parentKey = "HUD_MODULE_ACTIVE"

TheEyeAddon.Managers.UI:FormatData(
{
    tags = { "HUD", "ICON", "ACTIVE", "HEROLUST", },
    Child =
    {
        parentKey = parentKey,
    },
    -- @TODO change icon based on active aura
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
        iconObjectID = 2825,
    },
    PriorityRank =
    {
        ValueHandler =
        {
            validKeys = { [0] = 5, }
        },
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true, [4] = true, [8] = true, [16] = true, [32] = true, [64] = true, },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] 2825, },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] 32182, },
                    value = 4,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] 80353, },
                    value = 8,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] 90355, },
                    value = 16,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] 160452, },
                    value = 32,
                },
                {
                    eventEvaluatorKey = "UNIT_AURA_ACTIVE_CHANGED",
                    inputValues = { --[[sourceUnit]] "_", --[[destUnit]] "player", --[[spellID]] 102351, },
                    value = 64,
                },
            },
        },
    },
}
)