local TheEyeAddon = TheEyeAddon

local table = table


function TheEyeAddon.UI.Objects:FormatData(UIObject)
    UIObject.DisplayData.UIObject = UIObject

    local key = table.concat(UIObject.tags, "_")
    UIObject.key = key
    TheEyeAddon.UI.Objects.Instances[key] = UIObject

    local searchableTags = {}
    local tags = UIObject.tags
    for i=1,#tags do
        searchableTags[tags[i]] = true
    end
    UIObject.tags = searchableTags
end

function TheEyeAddon.UI.Objects:Initialize()
    local ComponentsAttachByTag = TheEyeAddon.UI.Templates.ComponentsAttachByTag
    local instances = TheEyeAddon.UI.Objects.Instances
    local pairs = pairs
    local TaggedComponents = TheEyeAddon.UI.Templates.TaggedComponents
    local UIObjectHasTag = TheEyeAddon.Tags.UIObjectHasTag

    for instanceKey,v in pairs(instances) do
        local uiObject = instances[instanceKey]

        for tag,v in pairs(TaggedComponents) do
            if tag == "DEFAULT" or UIObjectHasTag(uiObject, tag) then
                ComponentsAttachByTag(tag, uiObject)
            end
        end
    end
end