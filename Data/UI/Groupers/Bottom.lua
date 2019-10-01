local parentKey = "HUD"

TheEyeAddon.Managers.UI.GrouperAdd(
{
    tags = { "BOTTOM", },
    Child =
    {
        parentKey = parentKey,
    },
    EnabledState =
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
                    inputValues = { --[[uiObjectKey]] parentKey, --[[componentName]] "VisibleState" },
                    value = 2,
                },
            },
        },
    },
    Frame = {},
    Group =
    {
        childArranger = TheEyeAddon.Helpers.ChildArrangers.Delegate,
    },
    PriorityRank =
    {
        ValueHandler =
        {
            validKeys = { [0] = 2, }
        }
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [0] = true, },
        },
    },
})