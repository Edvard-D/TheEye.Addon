TheEyeAddon.UI.Modules.Primary.Components.Spell_15407 =
{
    priority = nil,
    tags = { "ICON", "PRIMARY", "SPELL", "DAMAGE" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Icon,
        dimensionTemplate = TheEyeAddon.UI.DimensionTemplates.Icon_Large,
        iconObjectType = "SPELL",
        iconObjectID = 15407,
        fontTemplate = TheEyeAddon.UI.Fonts.Templates.Icon
    },
    StateGroups =
    {
        Enabled =
        {
            OnValidKey = TheEyeAddon.UI.Components.EnableComponent,
            OnInvalidKey = TheEyeAddon.UI.Components.DisableComponent,
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
            OnValidKey = TheEyeAddon.UI.Components.ShowComponent,
            OnInvalidKey = TheEyeAddon.UI.Components.HideComponent,
            validKeys = { [0] = true, [4] = true, [6] = true},
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