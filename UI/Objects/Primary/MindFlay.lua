TheEyeAddon.UI.Objects:Add(
{
    priority = nil,
    tags = { "HUD", "ICON", "PRIMARY", "SPELL_15407" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        dimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = 15407,
        fontTemplate = TheEyeAddon.UI.Fonts.Templates.Icon.default
    },
    StateGroups =
    {
        Enabled =
        {
            OnValidKey = TheEyeAddon.UI.Objects.Enable,
            OnInvalidKey = TheEyeAddon.UI.Objects.Disable,
            validKeys = { [2] = true },
            StateListeners =
            {
                Target_Attackable =
                {
                    keyValue = 2
                }
            }
        },
        Visible =
        {
            OnValidKey = TheEyeAddon.UI.Objects.Show,
            OnInvalidKey = TheEyeAddon.UI.Objects.Hide,
            validKeys = { [0] = true, [4] = true, [6] = true },
            StateListeners =
            {
                Unit_Spellcast_Active =
                {
                    keyValue = 2,
                    inputValues = { --[[unit]] "player", --[[spellID]] 15407 }
                },
                Unit_Spellcast_StartedRecently =
                {
                    keyValue = 4,
                    inputValues = { --[[unit]] "player", --[[spellID]] 15407 }
                }
            }
        }
    }
}
)