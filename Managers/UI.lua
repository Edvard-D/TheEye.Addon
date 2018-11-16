TheEyeAddon.Managers.UI = {}
local this = TheEyeAddon.Managers.UI

local table = table


function this.FormatData(uiObject)
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

    this.currentUIObject = uiObject

    for componentKey,_ in pairs(uiObject) do
        local component = components[componentKey]
        local componentInstance = uiObject[componentKey]
        if component ~= nil and componentInstance.wasSetup == nil then
            this.currentComponent = componentInstance
            componentInstance.key = componentKey

            component.Setup(componentInstance, uiObject)
            componentInstance.wasSetup = true
        end
    end
end

function this.Initialize()
    local instances = TheEyeAddon.UI.Objects.Instances
    local pairs = pairs

    for instanceKey,_ in pairs(instances) do
        UIObjectSetup(instances[instanceKey])
    end

    this.currentUIObject = nil
    this.currentComponent = nil
    CastingBarFrame:UnregisterAllEvents()
end