local TheEyeAddon = TheEyeAddon

local table = table


function TheEyeAddon.UI.Objects:FormatData(uiObject)
    uiObject.DisplayData.UIObject = uiObject

    local key = table.concat(uiObject.tags, "_")
    uiObject.key = key
    TheEyeAddon.UI.Objects.Instances[key] = uiObject

    local searchableTags = {}
    local tags = uiObject.tags
    for i = 1, #tags do
        searchableTags[tags[i]] = true
    end
    uiObject.tags = searchableTags
end

function TheEyeAddon.UI.Objects:Initialize()
    local componentsAttachByTag = TheEyeAddon.UI.Templates.ComponentsAttachByTag
    local instances = TheEyeAddon.UI.Objects.Instances
    local pairs = pairs
    local taggedComponents = TheEyeAddon.UI.Templates.TaggedComponents
    local uiObjectHasTag = TheEyeAddon.Tags.UIObjectHasTag

    for instanceKey,v in pairs(instances) do
        local uiObject = instances[instanceKey]

        for tag,v in pairs(taggedComponents) do
            if tag == "DEFAULT" or uiObjectHasTag(uiObject, tag) then
                componentsAttachByTag(tag, uiObject)
            end
        end
    end
end