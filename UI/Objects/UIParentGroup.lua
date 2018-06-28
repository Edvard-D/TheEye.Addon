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
            validKeys = { [6] = true },
            Listeners =
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
            OnValidKey = TheEyeAddon.UI.Objects.Show,
            OnInvalidKey = TheEyeAddon.UI.Objects.Hide,
            validKeys = { [2] = true },
            Listeners =
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