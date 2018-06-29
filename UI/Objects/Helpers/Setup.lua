local TheEyeAddon = TheEyeAddon

local ipairs = ipairs
local pairs = pairs
local table = table


function TheEyeAddon.UI.Objects:FormatData(uiObject)
    uiObject.DisplayData.uiObject = uiObject

    local key = table.concat(uiObject.tags, "_")
    uiObject.key = key
    TheEyeAddon.UI.Objects.Instances[key] = uiObject

    local searchableTags = {}
    for i,tag in ipairs(uiObject.tags) do
        searchableTags[tag] = true
    end
    uiObject.tags = searchableTags
end

function TheEyeAddon.UI.Objects:Initialize()
    for k,uiObject in pairs(TheEyeAddon.UI.Objects.Instances) do
        TheEyeAddon.UI.Objects.ValueHandlers:Setup(uiObject)
        TheEyeAddon.UI.Objects.ListenerGroups:SetupGroup(uiObject, uiObject.ListenerGroups.Enabled)
    end
end