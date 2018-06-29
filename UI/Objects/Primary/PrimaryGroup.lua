local childrenTags = { --[[tags]] "HUD", "ICON", "PRIMARY" }


TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "HUD", "MODULE", "PRIMARY" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        parentKey = "GROUP_UIPARENT",
        GroupArranger = TheEyeAddon.UI.Objects.GroupArrangers.TopToBottom,
        DimensionTemplate =
        {
            PointSettings =
            {
                point = "TOP",
                relativePoint = "CENTER",
                yOffset = -50,
            }
        }
    },
    ValueHandlers =
    {
        Enabled =
        {
            Setup = TheEyeAddon.UI.Objects.ValueHandlers.SetupStateValue,
            ChangeValue = TheEyeAddon.UI.Objects.ValueHandlers.OnStateKeyChange,
            OnValidValue = TheEyeAddon.UI.Objects.ValueHandlers.Enable,
            OnInvalidValue = TheEyeAddon.UI.Objects.ValueHandlers.Disable,
            validValues = { [6] = true },
        },
        Visible =
        {
            Setup = TheEyeAddon.UI.Objects.ValueHandlers.SetupStateValue,
            ChangeValue = TheEyeAddon.UI.Objects.ValueHandlers.OnStateKeyChange,
            OnValidValue = TheEyeAddon.UI.Objects.ValueHandlers.Show,
            OnInvalidValue = TheEyeAddon.UI.Objects.ValueHandlers.Hide,
            validValues = { [2] = true },
        }
    },
    ListenerGroups =
    {
        Enabled =
        {
            type = "STATE",
            valueHandlerKey = "Enabled",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChangeValueByState,
            ListeningTo =
            {
                Module_Enabled =
                {
                    value = 2,
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY" }
                },
                UIObject_Visible =
                {
                    value = 4,
                    inputValues = { --[[uiObjectKey]] "GROUP_UIPARENT" }
                }
            }
        },
        Visible =
        {
            type = "STATE",
            valueHandlerKey = "Visible",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChangeValueByState,
            ListeningTo =
            {
                Unit_CanAttack_Unit =
                {
                    value = 2,
                    inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] "target" }
                }
            }
        },
        {
            type = "EVENT",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChildUpdateRegistration,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
                {
                    inputValues = childrenTags
                },
            }
        },
        {
            type = "EVENT",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChildrenSortDescending,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
                {
                    inputValues = childrenTags
                },
            }
        },
        {
            type = "EVENT",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChildrenArrange,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
                {
                    inputValues = childrenTags
                },
                UIOBJECT_WITHTAGS_SORTRANK_CHANGED =
                {
                    inputValues = childrenTags
                },
            }
        },
    }
}
)