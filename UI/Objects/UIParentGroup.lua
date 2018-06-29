TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "UIPARENT" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group
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
                Addon_Loaded =
                {
                    keyValue = 2,
                    inputValues = { --[[addonName]] "TheEyeAddon" }
                },
                Game_Data_Loaded =
                {
                    keyValue = 4
                    -- inputValues = nil
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
                Unit_Spec =
                {
                    keyValue = 2,
                    inputValues = { --[[unit]] "player", --[[specID]] 258 }
                }
            }
        }
    }
}
)