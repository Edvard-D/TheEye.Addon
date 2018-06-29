TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "HUD", "MODULE", "PRIMARY" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        parentKey = "GROUP_UIPARENT",
        dimensionTemplate =
        {
            width = 0,
            height = 0,
            point = "TOP",
            relativePoint = "CENTER",
            offsetX = 0,
            offsetY = -50,
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
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChangeValueByState,
            valueHandlerKey = "Enabled",
            ListeningTo =
            {
                Module_Enabled =
                {
                    keyValue = 2,
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY" }
                },
                UIObject_Visible =
                {
                    keyValue = 4,
                    inputValues = { --[[uiObjectKey]] "GROUP_UIPARENT" }
                }
            }
        },
        Visible =
        {
            type = "STATE",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChangeValueByState,
            valueHandlerKey = "Enabled",
            ListeningTo =
            {
                Unit_CanAttack_Unit =
                {
                    keyValue = 2,
                    inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] "target" }
                }
            }
        },
        {
            type = "EVENT",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.SortChildrenByPriority,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
                {
                    inputValues = { --[[tags]] "HUD", "ICON", "PRIMARY" }
                },
            }
        },
        {
            type = "EVENT",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.RegisterChild,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_INITIALIZED =
                {
                    inputValues = { --[[tags]] "HUD", "ICON", "PRIMARY" }
                },
            }
        },
    }
}
)