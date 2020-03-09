TheEye.Core.Managers.UI.GrouperAdd(
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
                    inputValues = { --[[addonName]] "TheEyeCore" },
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
        childArranger = TheEye.Core.Helpers.ChildArrangers.Delegate,
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
    uiObject.Frame.Dimensions.scale = _G["TheEyeAddonCharacterSettings"].UI.scale or TheEye.Core.Managers.Settings.Character.Default.UI.scale
    uiObject.Frame.Dimensions.PointSettings.offsetX = _G["TheEyeAddonCharacterSettings"].UI.Offset.X or TheEye.Core.Managers.Settings.Character.Default.UI.Offset.X
    uiObject.Frame.Dimensions.PointSettings.offsetY = _G["TheEyeAddonCharacterSettings"].UI.Offset.Y or TheEye.Core.Managers.Settings.Character.Default.UI.Offset.Y
end)