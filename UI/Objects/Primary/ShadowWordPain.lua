TheEyeAddon.UI.Objects:FormatData(
{
    priority = nil,
    tags = { "HUD", "ICON", "PRIMARY", "SPELL-589" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        parentKey = "GROUP_HUD_MODULE_PRIMARY",
        dimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = 589,
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
            validValues = { [0] = true, [2] = true, [6] = true },
        },
        SortRank =
        {
            value = 2,
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
                UIObject_Visible =
                {
                    keyValue = 2,
                    inputValues = { "GROUP_HUD_MODULE_PRIMARY" }
                }
            }
        },
        Visible =
        {
            type = "STATE",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChangeValueByState,
            valueHandlerKey = "Visible",
            ListeningTo =
            {
                Unit_Spellcast_CastRecently =
                {
                    keyValue = 2,
                    inputValues = { --[[unit]] "player", --[[spellID]] 589 }
                },
                Unit_Aura_Active =
                {
                    keyValue = 4,
                    inputValues = { --[[sourceUnit]] "player", --[[destUnit]] "target", --[[spellID]] 589 }
                }
            }
        }
    }
}
)