TheEyeAddon.Managers.UI.ModuleAdd(
{
    instanceID = "0000001",
    type = "ACTIVE",
    Filters =
    {
        {
            {
                type = "CATEGORY",
                value = "DAMAGE",
                subvalue = "SUMMON",
            },
            {
                type = "CATEGORY",
                value = "DAMAGE",
                subvalue = "TOTEM",
            },
        },
        {
            {
                type = "AURA_APPLIED",
            },
            {
                type = "CATEGORY",
                value = "DEFENSIVE",
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
            {
                type = "COOLDOWN",
                comparisonValues =
                {
                    value = 0,
                    type = "GreaterThan",
                },
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
                value = "TRIGGERED",
            },
        },
    },
    Group =
    {
        childArranger = "Vertical",
        sortActionName = "SortAscending",
        sortValueComponentName = "PriorityRank",
    },
    grouper = "LEFT",
    grouperPriority = 2,
    IconDimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Medium,
},
"IconGroups"
)