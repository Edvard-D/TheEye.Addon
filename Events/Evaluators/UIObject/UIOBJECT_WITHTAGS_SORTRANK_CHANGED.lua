local TheEyeAddon = TheEyeAddon


-- inputValues = { --[[tags]] "_", "_" }
--      tags: must be in alphabetical order
TheEyeAddon.Events.Evaluators.UIOBJECT_WITHTAGS_SORTRANK_CHANGED =
{
    type = "EVENT",
    reevaluateEvents =
    {
        UIOBJECT_SORTRANK_CHANGED = true,
    },
    customEvents =
    {
        "UIOBJECT_SORTRANK_CHANGED",
    }
}

function TheEyeAddon.Events.Evaluators.UIOBJECT_WITHTAGS_SORTRANK_CHANGED:Evaluate(valueGroup, event, ...)
    local uiObject = ...
    local hasTags = TheEyeAddon.UI.Objects.Tags:UIObjectHasTags(uiObject, valueGroup.inputValues, valueGroup.key)

    return hasTags, "UIOBJECT_WITHTAGS_SORTRANK_CHANGED", uiObject
end