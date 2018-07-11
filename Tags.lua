local TheEyeAddon = TheEyeAddon
TheEyeAddon.Tags = {}
local this = TheEyeAddon.Tags

local tagGroups = {}


local function GetTagGroup(tagKey)
    if tagGroups[tagKey] == nil then
        tagGroups[tagKey] = {}
    end
    
    return tagGroups[tagKey]
end

local function KeyHasTags(key, tags)
    for i=1, #tags do
        if key:find(tags[i]) == nil then
            return false
        end
    end
    return true
end

function this.UIObjectHasTags(uiObject, tags, tagKey)
    local tagGroup = GetTagGroup(tagKey)
    local uiObjectKey = uiObject.key

    if tagGroup[uiObjectKey] == nil then
        tagGroup[uiObjectKey] = KeyHasTags(uiObjectKey, tags)
    end

    return tagGroup[uiObjectKey]
end