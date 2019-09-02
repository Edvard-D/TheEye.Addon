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
        },
        {
            {
                type = "CATEGORY",
                value = "BUFF",
                subvalue = "POWER",
            },
            {
                type = "CAST_TYPE",
                value = "CAST",
            },
            {
                type = "CAST_TYPE",
                value = "INSTANT",
            },
        },
    },
    Group =
    {
        childArranger = "Vertical",
        sortActionName = "SortAscending",
        sortValueComponentName = "PriorityRank",
    },
    grouper = "CENTER",
    grouperPriority = 1,
    IconDimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Large,
},
"IconGroups"
)