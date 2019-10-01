TheEyeAddon.Managers.UI.GrouperAdd(
{
    tags = { "UIPARENT" },
    EnabledState =
    {
        ValueHandler =
        {
            validKeys = { [6] = true },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "ADDON_LOADED",
                    inputValues = { --[[addonName]] "TheEyeAddon" },
                    value = 2,
                },
                {
                    eventEvaluatorKey = "GAMEDATA_LOADED_CHANGED",
                    inputValues = nil,
                    value = 4,
                },
            },
        },
    },
    Frame =
    {
        Dimensions =
        {
            PointSettings =
            {
                point = "CENTER",
                relativePoint = "CENTER",
            },
        },
    },
    Group =
    {
        childArranger = TheEyeAddon.Helpers.ChildArrangers.Delegate,
    },
    VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [2] = true },
        },
        ListenerGroup =
        {
            Listeners =
            {
                {
                    eventEvaluatorKey = "UNIT_SPEC_CHANGED",
                    inputValues = { --[[unit]] "player", --[[specID]] 258 },
                    value = 2,
                },
            },
        },
    },
},
function(uiObject)
    uiObject.Frame.Dimensions.scale = TheEyeAddon.Managers.Settings.Character.Saved.UI.scale or TheEyeAddon.Managers.Settings.Character.Default.UI.scale
    uiObject.Frame.Dimensions.PointSettings.offsetX = TheEyeAddon.Managers.Settings.Character.Saved.UI.Offset.X or TheEyeAddon.Managers.Settings.Character.Default.UI.Offset.X
    uiObject.Frame.Dimensions.PointSettings.offsetY = TheEyeAddon.Managers.Settings.Character.Saved.UI.Offset.Y or TheEyeAddon.Managers.Settings.Character.Default.UI.Offset.Y
end)