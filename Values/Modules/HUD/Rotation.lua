TheEyeAddon.Managers.UI.ModuleAdd(
{
    instanceID = "0000003",
    type = "ROTATION",
    Filters =
    {
        {
            {
                type = "CATEGORY",
                value = "DAMAGE",
            },
            {
                type = "TARGETING",
                value = "DIRECT",
            },
            {
                type = "TARGETING",
                value = "POSITIONAL",
            },
            {
                type = "TARGETING",
                value = "SELF",
            },
            {
                type = "USAGE_RATE",
                value = 4,
            },
            {
                type = "USAGE_RATE",
                value = 5,
            },
        },
    },
    Group =
    {
        childArranger = "Vertical",
        sortActionName = "SortDescending",
        sortValueComponentName = "PriorityRank",
    },
    grouper = "CENTER",
    grouperPriority = 1,
    IconDimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Large,
},
"IconGroups"
)