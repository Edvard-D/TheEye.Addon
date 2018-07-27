local table = table


function TheEyeAddon.UI.Objects:FormatData(uiObject)
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

local function UIObjectSetup(uiObject)
    local components = TheEyeAddon.UI.Components
    local pairs = pairs

    for componentKey,_ in pairs(uiObject) do
        local component = components[componentKey]
        if component ~= nil then
            component.Setup(uiObject[componentKey], uiObject)
        end
    end
end

function TheEyeAddon.UI.Objects:Initialize()
    local instances = TheEyeAddon.UI.Objects.Instances
    local pairs = pairs

    for instanceKey,_ in pairs(instances) do
        UIObjectSetup(instances[instanceKey])
    end
end