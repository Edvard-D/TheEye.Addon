TheEyeAddon.Managers.Settings.Account.Default =
{
    Debug =
    {
        isLoggingEnabled = false,
        isPrintEnabled = false,
    },
}

TheEyeAddon.Managers.Settings.Character.Default =
{
    IconGroups =
    {
        {
            instanceID = "0000001",
            type = "ACTIVE",
            Filters =
            {
                {
                    {
                        type = "CATEGORY",
                        value = "DAMAGE",
                        subvalue = "MINION",
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
                        value = "DAMAGE",
                        subvalue = "BUFF",
                    },
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
                    {
                        type = "USAGE_RATE",
                        value = 4,
                    },
                },
            },
            Group =
            {
                childArranger = "TopToBottom",
                sortActionName = "SortDescending",
                sortValueComponentName = "PriorityRank",
            },
            grouper = "LEFT",
            grouperPriority = 2,
            IconDimensions = TheEyeAddon.Values.DimensionTemplates.Icon.Medium,
        },
    },
}