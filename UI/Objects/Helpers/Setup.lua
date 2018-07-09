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
    local EnabledStateSetup = TheEyeAddon.UI.Components.EnabledState.Setup
    local pairs = pairs
    local TaggedComponents = TheEyeAddon.UI.Templates.TaggedComponents
    local UIObjectHasTags = TheEyeAddon.UI.Tags.UIObjectHasTags

    for instanceKey,UIObject in pairs(TheEyeAddon.UI.Objects.Instances) do
        UIObject.EnabledState = UIObject.EnabledState or {}
        EnabledStateSetup(UIObject.EnabledState, UIObject)

        for tag,v in pairs(TaggedComponents) do
            if tag == "DEFAULT" or UIObjectHasTags(UIObject, tag) then
                ComponentsAttachByTag(tag, UIObject)
            end
        end
    end
end