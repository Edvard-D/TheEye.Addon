TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "UIPARENT" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        DimensionTemplate =
        {
            PointSettings =
            {
                point = "CENTER",
                relativePoint = "CENTER",
                yOffset = -100,
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
                Addon_Loaded =
                {
                    value = 2,
                    inputValues = { --[[addonName]] "TheEyeAddon" }
                },
                Game_Data_Loaded =
                {
                    value = 4
                    -- inputValues = nil
                }
            }
        },
        Visible =
        {
            type = "STATE",
            valueHandlerKey = "Visible",
            OnSetup = TheEyeAddon.UI.Objects.ListenerGroups.ValueHandlerTriggerEvaluation,
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChangeValueByState,
            OnTeardown = TheEyeAddon.UI.Objects.ListenerGroups.ValueHandlerTriggerEvaluation,
            ListeningTo =
            {
                Unit_Spec =
                {
                    value = 2,
                    inputValues = { --[[unit]] "player", --[[specID]] 258 }
                }
            }
        }
    }
}
)