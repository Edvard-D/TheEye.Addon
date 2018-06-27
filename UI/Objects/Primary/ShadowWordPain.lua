TheEyeAddon.UI.Objects:Add(
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
    StateGroups =
    {
        Enabled =
        {
            OnValidKey = TheEyeAddon.UI.Objects.Enable,
            OnInvalidKey = TheEyeAddon.UI.Objects.Disable,
            validKeys = { [2] = true },
            Listeners =
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
            OnValidKey = TheEyeAddon.UI.Objects.Show,
            OnInvalidKey = TheEyeAddon.UI.Objects.Hide,
            validKeys = { [0] = true, [2] = true },
            Listeners =
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