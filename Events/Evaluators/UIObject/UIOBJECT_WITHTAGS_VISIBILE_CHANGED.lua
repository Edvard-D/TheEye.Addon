local TheEyeAddon = TheEyeAddon


-- inputValues = { --[[tags]] "_", "_" }
--      tags: must be in alphabetical order
TheEyeAddon.Events.Evaluators.UIOBJECT_WITHTAGS_VISIBILE_CHANGED =
{
    type = "EVENT",
    reevaluateEvents =
    {
        UIOBJECT_HIDDEN = true,
        UIOBJECT_SHOWN = true,
    },
    customEvents =
    {
        "UIOBJECT_HIDDEN",
        "UIOBJECT_SHOWN",
    }
}

function TheEyeAddon.Events.Evaluators.UIOBJECT_WITHTAGS_VISIBILE_CHANGED:Evaluate(valueGroup, event, ...)
    local uiObject = ...
    local hasTags = TheEyeAddon.UI.Objects.Tags:UIObjectHasTags(uiObject, valueGroup.inputValues, valueGroup.key)

    return hasTags, "UIOBJECT_WITHTAGS_VISIBILE_CHANGED", uiObject
end