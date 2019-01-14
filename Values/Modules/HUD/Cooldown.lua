TheEyeAddon.Managers.UI.ModuleAdd(
{
    instanceID = "0000002",
    type = "COOLDOWN",
    Filters =
    {
        {
            {
                type = "COOLDOWN",
                comparisonValues =
                {
                    value = 20,
                    type = "GreaterThanEqualTo",
                },
            },
        },
    },
    Group =
    {
        childArranger = "Vertical",
        sortActionName = "SortAscending",
        sortValueComponentName = "Cooldown",
    },
    grouper = "LEFT",
    grouperPriority = 1,
    IconDimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Small,
    PriorityDisplayers =
    {
        "ACTIVE",
        "ROTATION",
    },
},
"IconGroups"
)