TheEyeAddon.Managers.UI.ModuleAdd(
{
    instanceID = "0000004",
    type = "SITUATIONAL",
    Filters =
    {
        {
            {
                type = "USAGE_RATE",
                value = 1,
            },
            {
                type = "USAGE_RATE",
                value = 2,
            },
            {
                type = "USAGE_RATE",
                value = 3,
            },
        },
    },
    Group =
    {
        childArranger = "Vertical",
        sortActionName = "SortDescending",
        sortValueComponentName = "PriorityRank",
    },
    grouper = "RIGHT",
    grouperPriority = 1,
    IconDimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Medium,
},
"IconGroups"
)