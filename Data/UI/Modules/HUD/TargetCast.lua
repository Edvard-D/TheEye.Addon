TheEyeAddon.Managers.UI.ModuleAdd("CastBars",
{
    unit = "target",
    Dimensions =
    {
        width = 140,
        height = 15,
    },
    instanceID = "0000006",
    type = "TARGET_CAST",
    grouper = "TOP",
    grouperPriority = 2,
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
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObjectKey]] "ENCOUNTER_ALERT_0000008", --[[componentName]] "VisibleState" },
                    value = 2,
                },
            },
        },
    },
})