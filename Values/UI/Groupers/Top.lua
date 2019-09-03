local parentKey = "HUD"

TheEyeAddon.Managers.UI.GrouperAdd(
{
    tags = { "TOP", },
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
        childArranger = TheEyeAddon.Helpers.ChildArrangers.Vertical,
        sortActionName = "SortAscending",
        sortValueComponentName = "PriorityRank",
    },
    PriorityRank =
    {
        ValueHandler =
        {
            validKeys = { [0] = 1, }
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