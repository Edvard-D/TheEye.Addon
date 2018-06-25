TheEyeAddon.UI.Objects:Add(
{
    tags = { "GROUP", "HUD", "MODULE", "PRIMARY" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        dimensionTemplate =
        {
            width = 0,
            height = 0,
            point = "TOP",
            relativePoint = "CENTER",
            offsetX = 0,
            offsetY = -50,
        }
    },
    StateGroups =
    {
        Enabled =
        {
            OnValidKey = TheEyeAddon.UI.Objects.Enable,
            OnInvalidKey = TheEyeAddon.UI.Objects.Disable,
            validKeys = { [6] = true },
            StateListeners =
            {
                Setting_Module_Enabled =
                {
                    keyValue = 2,
                    inputValues = { "GROUP_HUD_MODULE_PRIMARY" }
                },
                UIObject_Visible =
                {
                    keyValue = 4,
                    inputValues = { "GROUP_UIPARENT" }
                }
            }
        },
        Visible =
        {
            OnValidKey = TheEyeAddon.UI.Objects.Show,
            OnInvalidKey = TheEyeAddon.UI.Objects.Hide,
            validKeys = { [2] = true },
            StateListeners =
            {
                Target_Attackable =
                {
                    keyValue = 2
                }
            }
        }
    }
}
)