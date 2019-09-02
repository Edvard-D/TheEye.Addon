TheEyeAddon.Managers.UI.ModuleAdd(
{
    instanceID = "0000004",
    type = "SITUATIONAL",
    Filters =
    {
        {
            {
                type = "CATEGORY",
                value = "BUFF",
                subvalue = "SURVIVABILITY",
            },
            {
                type = "CATEGORY",
                value = "CC",
            },
            {
                type = "CATEGORY",
                value = "REMOVE_DEBUFF",
                subvalue = "CC",
            },
        },
        {
            {
                type = "CATEGORY",
                value = "DEFENSIVE",
            },
            {
                type = "CATEGORY",
                value = "HEAL",
            },
            {
                type = "CATEGORY",
                value = "REMOVE_BUFF",
            },
            {
                type = "CATEGORY",
                value = "UTILITY",
                subvalue = "COMBAT",
            },
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
        sortValueComponentName = "PriorityRank",
    },
    grouper = "RIGHT",
    grouperPriority = 1,
    IconDimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Medium,
},
"IconGroups"
)