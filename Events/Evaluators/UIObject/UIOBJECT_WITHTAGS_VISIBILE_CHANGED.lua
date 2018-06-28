local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local select = select
local table = table


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
    local uiObjectKey = uiObject.key

    for i,tag in ipairs(valueGroup.inputValues) do
        if uiObjectKey:find(tag) == nil then
            return false
        end
    end
    
    return true, "UIOBJECT_WITHTAGS_VISIBILE_CHANGED", uiObject
end