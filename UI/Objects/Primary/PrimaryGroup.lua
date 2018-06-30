local thisKey = { --[[uiObjectKey]] "GROUP_HUD_MODULE_PRIMARY" } -- @TODO have Setup auto populate fields with some special character, like "#thisKey"
local childrenTags = { --[[tags]] "HUD", "ICON", "PRIMARY" }


TheEyeAddon.UI.Objects:FormatData(
{
    tags = { "GROUP", "HUD", "MODULE", "PRIMARY" },
    DisplayData =
    {
        factory = TheEyeAddon.UI.Factories.Group,
        parentKey = "GROUP_UIPARENT",
        GroupArranger = TheEyeAddon.UI.Objects.GroupArrangers.TopToBottom,
        DimensionTemplate =
        {
            PointSettings =
            {
                point = "TOP",
                relativePoint = "CENTER",
                yOffset = -50,
            }
        }
    },
    ValueHandlers =
    {
        Enabled =
        {
            Setup = TheEyeAddon.UI.Objects.ValueHandlers.SetupStateValue,
            ChangeValue = TheEyeAddon.UI.Objects.ValueHandlers.OnStateKeyChange,
            OnValidValue = TheEyeAddon.UI.Objects.ValueHandlers.Enable,
            OnInvalidValue = TheEyeAddon.UI.Objects.ValueHandlers.Disable,
            validValues = { [6] = true },
        },
        Visible =
        {
            Setup = TheEyeAddon.UI.Objects.ValueHandlers.SetupStateValue,
            ChangeValue = TheEyeAddon.UI.Objects.ValueHandlers.OnStateKeyChange,
            OnValidValue = TheEyeAddon.UI.Objects.ValueHandlers.Show,
            OnInvalidValue = TheEyeAddon.UI.Objects.ValueHandlers.Hide,
            validValues = { [2] = true },
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
                Module_Enabled =
                {
                    value = 2,
                    inputValues = thisKey
                },
                UIObject_Visible =
                {
                    value = 4,
                    inputValues = { --[[uiObjectKey]] "GROUP_UIPARENT" }
                }
            }
        },
        Visible =
        {
            type = "STATE",
            valueHandlerKey = "Visible",
            OnEvaluate = TheEyeAddon.UI.Objects.ListenerGroups.ChangeValueByState,
            OnTeardown = TheEyeAddon.UI.Objects.ListenerGroups.StateSetFalse,
            ListeningTo =
            {
                Unit_CanAttack_Unit =
                {
                    value = 2,
                    inputValues = { --[[attackerUnit]] "player", --[[attackedUnit]] "target" }
                }
            }
        },
        {
            type = "EVENT",
            OnEvaluate = TheEyeAddon.UI.Objects.GroupChildren.ChildrenUpdateRegistration,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
                {
                    inputValues = childrenTags
                },
                UIOBJECT_VISIBILE_CHANGED =
                {
                    inputValues = thisKey
                },
            }
        },
        {
            type = "EVENT",
            OnEvaluate = TheEyeAddon.UI.Objects.GroupChildren.ChildrenSortDescending,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
                {
                    inputValues = childrenTags
                },
            }
        },
        {
            type = "EVENT",
            OnEvaluate = TheEyeAddon.UI.Objects.GroupChildren.ChildrenArrange,
            ListeningTo =
            {
                UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
                {
                    inputValues = childrenTags
                },
                UIOBJECT_WITHTAGS_SORTRANK_CHANGED =
                {
                    inputValues = childrenTags
                },
            }
        },
    }
}
)