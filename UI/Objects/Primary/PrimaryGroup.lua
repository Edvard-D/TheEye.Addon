TheEyeAddon.UI.Objects:Add(
{
    tags = { "GROUP", "HUD", "MODULE", "PRIMARY" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        parentKey = "GROUP_UIPARENT",
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
    ListenerGroups =
    {
        {
            type = "EVENT",
            OnEvent = nil, -- @TODO
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
                {
                    inputValues = { --[[tags]] "HUD", "ICON", "PRIMARY" }
                },
            }
        },
        {
            type = "EVENT",
            OnEvent = TheEyeAddon.UI.Objects.RegisterChild,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_INITIALIZED =
                {
                    inputValues = { --[[tags]] "HUD", "ICON", "PRIMARY" }
                },
            }
        },
        Enabled =
        {
            type = "STATE",
            OnValidKey = TheEyeAddon.UI.Objects.Enable,
            OnInvalidKey = TheEyeAddon.UI.Objects.Disable,
            validKeys = { [6] = true },
            ListeningTo =
            {
                Module_Enabled =
                {
                    keyValue = 2,
                    inputValues = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY" }
                },
                UIObject_Visible =
                {
                    keyValue = 4,
                    inputValues = { --[[uiObjectKey]] "GROUP_UIPARENT" }
                }
            }
        },
        Visible =
        {
            type = "STATE",
            OnValidKey = TheEyeAddon.UI.Objects.Show,
            OnInvalidKey = TheEyeAddon.UI.Objects.Hide,
            validKeys = { [2] = true },
            ListeningTo =
            {
                Unit_CanAttack_Unit =
                {
                    keyValue = 2,
                    inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] "target" }
                }
            }
        }
    }
}
)