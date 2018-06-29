local TheEyeAddon = TheEyeAddon
TheEyeAddon.UI.Objects.Tags = {}

local ipairs = ipairs
local table = table
local tagGroups = {}


local function KeyHasTags(key, tags)
    for i=1, #tags do
        if key:find(tags[i]) == nil then
            return false
        end
    end
    return true
end


function TheEyeAddon.UI.Objects.Tags:UIObjectHasTags(uiObject, tags, tagsConcatenated)
    local tagGroup = tagGroups[tagsConcatenated]

    if tagGroup ~= nil and tagGroup[uiObject.key] ~= nil then
        return tagGroup[uiObject.key]
    else
        tagGroup = {}
        local hasTags = KeyHasTags(uiObject.key, tags)
        tagGroup[uiObject.key] = hasTags
        
        return hasTags
    end
end