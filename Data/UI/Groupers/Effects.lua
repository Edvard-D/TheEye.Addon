TheEye.Core.Managers.UI.GrouperAdd(
{
    tags = { "EFFECTS", },
},
function(uiObject)
    local parentKey
    local enabledStateListenerComponentName
    local targetFrameSettings = _G["TheEyeCharacterSettings"].UI.Modules["TARGET_FRAME"]

    if targetFrameSettings.enabled == true then
        parentKey = "TARGET_FRAME_0000005"
        uiObject.Child =
        {
            parentKey = parentKey,
            frameAttachPointPath =
            {
                "targetFrame",
                "EffectAttachPoint",
            },
        }
        enabledStateListenerComponentName = "TargetFrame"
    else
        parentKey = "CENTER_TOP"
        uiObject.Child =
        {
            parentKey = parentKey,
        }
        enabledStateListenerComponentName = "VisibleState"
    end

    uiObject.EnabledState =
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
                    eventEvaluatorKey = "UIOBJECT_COMPONENT_STATE_CHANGED",
                    inputValues = { --[[uiObjectKey]] parentKey, --[[componentName]] enabledStateListenerComponentName },
                    value = 2,
                },
            },
        },
    }
    uiObject.Frame =
    {
        Dimensions =
        {
            width = 100,
            height = 100,
        },
    }
    uiObject.Group =
    {
        childArranger = TheEye.Core.Helpers.ChildArrangers.Delegate,
        sortActionName = "SortAscending",
        sortValueComponentName = "PriorityRank",
    }
    uiObject.PriorityRank =
    {
        ValueHandler =
        {
            validKeys = { [0] = 1, }
        }
    }
    uiObject.VisibleState =
    {
        ValueHandler =
        {
            validKeys = { [0] = true, },
        },
    }
end)