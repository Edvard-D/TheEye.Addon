TheEyeAddon.UI.Objects:Add(
{
    tags = { "GROUP", "UIPARENT" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group
    },
    StateGroups =
    {
        Enabled =
        {
            OnValidKey = TheEyeAddon.UI.Objects.Enable,
            OnInvalidKey = TheEyeAddon.UI.Objects.Disable,
            validKeys = { [14] = true },
            Listeners =
            {
                Addon_Loaded =
                {
                    keyValue = 2,
                    inputValues = { "TheEyeAddon" }
                },
                Player_Class =
                {
                    keyValue = 4,
                    inputValues = { 5 }
                },
                Unit_Spec =
                {
                    keyValue = 8,
                    inputValues = { --[[unit]] "player", --[[specID]] 258 }
                }
            }
        },
        Visible =
        {
            OnValidKey = TheEyeAddon.UI.Objects.Show,
            OnInvalidKey = TheEyeAddon.UI.Objects.Hide,
            validKeys = { [0] = true }
        }
    }
}
)