local parentKey = "HUD"

TheEye.Core.Managers.UI.GrouperAdd(
{
    tags = { "CENTER", },
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
        childArranger = TheEye.Core.Helpers.ChildArrangers.Vertical,
        childPadding = 5,
        sortActionName = "SortAscending",
        sortValueComponentName = "PriorityRank",
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