TheEyeAddon.UI.Objects:FormatData(
{
    priority = nil,
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-15407" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        parentKey = "GROUP_HUD_MODULE_PRIMARY",
        DimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = 15407,
        fontTemplate = TheEyeAddon.UI.Fonts.Templates.Icon.default
    },
    ValueHandlers =
    {
        Enabled =
        {
            Setup = TheEyeAddon.UI.Objects.ValueHandlers.SetupStateValue,
            ChangeValue = TheEyeAddon.UI.Objects.ValueHandlers.OnStateKeyChange,
            OnValidValue = TheEyeAddon.UI.Objects.ValueHandlers.Enable,
            OnInvalidValue = TheEyeAddon.UI.Objects.ValueHandlers.Disable,
            validValues = { [2] = true },
        },
        Visible =
        {
            Setup = TheEyeAddon.UI.Objects.ValueHandlers.SetupStateValue,
            ChangeValue = TheEyeAddon.UI.Objects.ValueHandlers.OnStateKeyChange,
            OnValidValue = TheEyeAddon.UI.Objects.ValueHandlers.Show,
            OnInvalidValue = TheEyeAddon.UI.Objects.ValueHandlers.Hide,
            validValues = { [0] = true, [4] = true, [6] = true },
        },
        SortRank =
        {
            value = 1,
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
                UIObject_Visible =
                {
                    value = 2,
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY" }
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
                Unit_Spellcast_Active =
                {
                    value = 2,
                    inputValues = { --[[unit]] "player", --[[spellID]] 15407 }
                },
                Unit_Spellcast_CastRecently =
                {
                    value = 4,
                    inputValues = { --[[unit]] "player", --[[spellID]] 15407 }
                }
            }
        }
    }
}
)