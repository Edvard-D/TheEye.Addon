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
    local components = TheEyeAddon.UI.Components
    local instances = TheEyeAddon.UI.Objects.Instances
    local pairs = pairs

    for instanceKey,v in pairs(instances) do
        local uiObject = instances[instanceKey]

        for componentKey,v in pairs(uiObject) do
            local component = components[componentKey]
            if component ~= nil then
                component.Setup(uiObject[componentKey], uiObject)
            end
        end
    end
end