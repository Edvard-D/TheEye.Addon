TheEyeAddon.UI.Modules.Instances.Primary.Components.Spell_15407 =
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
            validKeys = { 2 },
            StateListeners =
            {
                Target_Attackable = { stateValue = 2, comparison = TheEyeAddon.Comparisons.EqualTo, comparisonValue = true }
            }
        },
        Visible =
        {
            OnValidKey = TheEyeAddon.UI.Components.ShowComponent,
            OnInvalidKey = TheEyeAddon.UI.Components.HideComponent,
            validKeys = { 2, 4 },
            StateListeners =
            {
                Player_Casting = { stateValue = 2, comparison = TheEyeAddon.Comparisons.NotEqualTo, comparisonValue = 15407 },
                Player_RecentlyCast = { stateValue = 4, comparison = TheEyeAddon.Comparisons.EqualTo, comparisonValue = 15407 }
            }
        }
    }
}